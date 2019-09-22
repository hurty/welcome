import React from "react";
import List from "./list";
import { DragDropContext } from "react-beautiful-dnd";
import Socket from "../socket";

class Board extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      job_offer: {
        stages: [],
        applications: []
      }
    };
  }

  dragApplication(applicationId, source, destination) {
    // dropped outside of a list
    if (!destination) return;

    // skip updates when moved to the same position
    if (
      destination.droppableId === source.droppableId &&
      destination.index === source.index
    )
      return;

    this.updateApplicationPosition(
      applicationId,
      source.droppableId,
      source.index,
      destination.droppableId,
      destination.index
    );

    // Server synchronization
    const updatedApplicationPayload = {
      application: {
        id: applicationId,
        stage_id: destination.droppableId,
        position: destination.index
      }
    };

    this.channel.push("update_application", updatedApplicationPayload);
    console.log("Server sync", updatedApplicationPayload);
  }

  updateApplicationPosition(
    applicationId,
    oldStageId,
    oldPosition,
    newStageId,
    newPosition
  ) {
    const sourceStage = this.getStage(oldStageId);
    const destinationStage = this.getStage(newStageId);

    // Prevent re-updating position if the local state is already synced.
    const currentPosition = destinationStage.applications_ids.indexOf(
      applicationId
    );
    if (currentPosition === newPosition) return;

    sourceStage.applications_ids.splice(oldPosition, 1);
    destinationStage.applications_ids.splice(newPosition, 0, applicationId);

    this.setState(this.state);
    console.log("Sync local state");
  }

  getStage(id) {
    return this.state.job_offer.stages.find(stage => stage.id === id);
  }

  getApplication(id) {
    return this.state.job_offer.applications.find(
      application => application.id === id
    );
  }

  onDragEnd(result) {
    this.dragApplication(result.draggableId, result.source, result.destination);
  }

  handleChannel() {
    this.channel = Socket.channel("job_offer:board", {});

    this.channel
      .join()
      .receive("ok", resp => {
        console.log("Joined the 'job_offer' channel successfully", resp);
        this.channel.push("get_job_offer", {});
      })
      .receive("error", resp => {
        console.log("Unable to join the 'job_offer' channel", resp);
      });

    this.handleChannelReplies();
  }

  handleChannelReplies() {
    this.channel.on("phx_reply", payload => {
      switch (payload.response.type) {
        case "get_job_offer":
          console.log("Load job offer data", payload.response);
          this.setState({ job_offer: payload.response.job_offer });
          break;
        default:
          return;
      }
    });

    this.channel.on("update_application_position", payload => {
      this.updateApplicationPosition(
        payload.application_id,
        payload.old_stage_id,
        payload.old_position,
        payload.new_stage_id,
        payload.new_position
      );
    });
  }

  componentDidMount() {
    this.handleChannel();
  }

  render() {
    const stages = this.state.job_offer.stages.map(stage => {
      const applications = stage.applications_ids.map(applicationId =>
        this.getApplication(applicationId)
      );
      return (
        <List key={stage.id} stage={stage} applications={applications}></List>
      );
    });

    return (
      <section className="board">
        <DragDropContext onDragEnd={this.onDragEnd.bind(this)}>
          {stages}
        </DragDropContext>
      </section>
    );
  }
}

export default Board;
