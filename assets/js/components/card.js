import React from "react";

class Card extends React.Component {
  render() {
    return (
      <li className="card">
        <div className="applicant__name">{this.props.applicant.name}</div>
        <div className="applicant__info">{this.props.applicant.title}</div>
      </li>
    );
  }
}

export default Card;
