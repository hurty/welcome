import React from "react";
import Card from "./card";
import { Droppable } from "react-beautiful-dnd";

const getListStyle = isDraggingOver => ({
  background: isDraggingOver ? "#FDF3E6" : "transparent"
});

class List extends React.Component {
  getCardsCount() {
    return this.props.stage.applicants.length;
  }

  render() {
    const applicantsList = this.props.stage.applicants.map(
      (applicant, index) => (
        <Card applicant={applicant} key={applicant.id} index={index}></Card>
      )
    );

    return (
      <div className="list">
        <div className="list__header">
          <div className="list__name">{this.props.stage.name}</div>
          <div className="list__counter">{this.getCardsCount()}</div>
        </div>

        <Droppable droppableId={this.props.stage.id}>
          {(provided, snapshot) => (
            <ul
              className="list__cards"
              ref={provided.innerRef}
              style={getListStyle(snapshot.isDraggingOver)}
            >
              {applicantsList}
              {provided.placeholder}
            </ul>
          )}
        </Droppable>
      </div>
    );
  }
}

export default List;
