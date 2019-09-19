import React from "react";
import List from "./list";

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

  componentDidMount() {
    console.log("TODO: Retrieve board data");
  }

  render() {
    const stages = this.state.stages.map(stage => (
      <List stage={stage} key={stage.id}></List>
    ));

    return <section className="board">{stages}</section>;
  }
}

export default Board;
