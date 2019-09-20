import React from "react";
import List from "./list";
import { DragDropContext } from "react-beautiful-dnd";

class Board extends React.Component {
  constructor(props) {
    const boardExampleData = {
      stages: [
        {
          id: 1,
          name: "A rencontrer",
          applicants: [
            { id: 1, name: "Pierre Hurtevent", title: "Developer" },
            { id: 2, name: "John Paul", title: "Astronaut" }
          ]
        },
        {
          id: 2,
          name: "Entretien",
          applicants: [
            {
              id: 3,
              name: "George Abitbol",
              title: "the Most Classy Man on Earth"
            }
          ]
        }
      ]
    };

    super(props);
    this.state = boardExampleData;
  }

  moveCard(source, destination) {
    const sourceList = this.getList(source.droppableId);
    const destinationList = this.getList(destination.droppableId);

    const [movedCard] = sourceList.applicants.splice(source.index, 1);
    destinationList.applicants.splice(destination.index, 0, movedCard);

    this.setState(this.state);

    console.log("TODO: server sync");
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

  componentDidMount() {
    console.log("TODO: Retrieve board data");
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
