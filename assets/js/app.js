// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

// import React from "react";
// import ReactDOM from "react-dom";

// import Board from "./components/board";

// ReactDOM.render(<Board />, document.getElementById("board"));

import { Socket } from "phoenix";
import LiveSocket from "../../deps/phoenix_live_view";
import { Sortable, Plugins } from "@shopify/draggable";

let Hooks = {};
Hooks.Board = {
  mounted() {
    const sortable = new Sortable(document.querySelectorAll(".list__cards"), {
      draggable: ".card",
      mirror: {
        constrainDimensions: true
      },
      swapAnimation: {
        duration: 200,
        easingFunction: "ease-in-out"
      },
      plugins: [Plugins.SwapAnimation]
    });

    sortable.on("sortable:stop", event => {
      console.log(event);
      const source = event.data.dragEvent.data.source;
      const applicationId = source.getAttribute("data-application-id");
      const newStageId = event.data.newContainer.getAttribute("data-stage-id");
      const newIndex = event.data.newIndex;
      const applicationPayload = {
        application: {
          id: applicationId,
          stage_id: newStageId,
          position: newIndex
        }
      };
      this.pushEvent("update_application", applicationPayload);
    });
  }
};

let liveSocket = new LiveSocket("/live", Socket, { hooks: Hooks });
liveSocket.connect();
