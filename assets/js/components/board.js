import React from "react";
import List from "./list";
import { DragDropContext } from "react-beautiful-dnd";
import Socket from "../socket";

class Board extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      stages: []
    };
  }

  moveCard(source, destination) {
    const sourceList = this.getList(source.droppableId);
    const destinationList = this.getList(destination.droppableId);

    const [movedApplication] = sourceList.applications.splice(source.index, 1);
    destinationList.applications.splice(destination.index, 0, movedApplication);

    this.setState(this.state);

    const updatedApplicationPayload = {
      application: {
        id: movedApplication.id,
        stage_id: destination.droppableId,
        position: destination.index
      }
    };

    this.channel.push("update_application", updatedApplicationPayload);
    console.log("Server sync", updatedApplicationPayload);
  }

  getList(id) {
    return this.state.stages.find(stage => stage.id === id);
  }

  onDragEnd(result) {
    const { source, destination } = result;

    // dropped outside of a list
    if (!destination) return;

    this.moveCard(source, destination);
  }

  handleChannel() {
    this.channel = Socket.channel("job_offer:board", {});

    this.channel
      .join()
      .receive("ok", resp => {
        console.log("Joined the 'job_offer' channel successfully", resp);
        this.channel.push("list_stages", {});
      })
      .receive("error", resp => {
        console.log("Unable to join the 'job_offer' channel", resp);
      });

    this.handleChannelReplies();
  }

  handleChannelReplies() {
    this.channel.on("phx_reply", payload => {
      switch (payload.response.type) {
        case "list_stages":
          console.log("Load initial data", payload.response);
          this.loadStages(payload.response.stages);
          break;
        default:
          return;
      }
    });
  }

  loadStages(stages) {
    this.setState({ stages: stages });
  }

  componentDidMount() {
    this.handleChannel();
  }

  render() {
    const stages = this.state.stages.map(stage => (
      <List stage={stage} key={stage.id}></List>
    ));

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
