import React from "react";
import { Draggable } from "react-beautiful-dnd";

class Card extends React.Component {
  render() {
    return (
      <Draggable
        key={this.props.application.id}
        draggableId={this.props.application.id}
        index={this.props.index}
      >
        {(provided, snapshot) => (
          <li
            className="card"
            ref={provided.innerRef}
            {...provided.draggableProps}
            {...provided.dragHandleProps}
          >
            <div className="applicant__name">
              {this.props.application.applicant.name}
            </div>
            <div className="applicant__info">
              {this.props.application.applicant.title}
            </div>
          </li>
        )}
      </Draggable>
    );
  }
}

export default Card;
