import React from "react";
import Card from "./card";

class List extends React.Component {
  getCardsCount() {
    return this.props.stage.applicants.length;
  }

  render() {
    const applicantsList = this.props.stage.applicants.map(applicant => (
      <Card applicant={applicant} key={applicant.id}></Card>
    ));

    return (
      <div className="list">
        <div className="list__header">
          <div className="list__name">{this.props.stage.name}</div>
          <div className="list__counter">{this.getCardsCount()}</div>
        </div>

        <ul className="list__cards">{applicantsList}</ul>
      </div>
    );
  }
}

export default List;
