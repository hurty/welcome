import React from "react";
import { Draggable } from "react-beautiful-dnd";

class Card extends React.Component {
  render() {
    return (
      <Draggable
        key={this.props.applicant.id}
        draggableId={this.props.applicant.id}
        index={this.props.index}
      >
        {(provided, snapshot) => (
          <li
            className="card"
            ref={provided.innerRef}
            {...provided.draggableProps}
            {...provided.dragHandleProps}
          >
            <div className="applicant__name">{this.props.applicant.name}</div>
            <div className="applicant__info">{this.props.applicant.title}</div>
          </li>
        )}
      </Draggable>
    );
  }
}

export default Card;
