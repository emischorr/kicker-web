// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})
socket.connect()

let channel = socket.channel("match:live", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

channel.on("result", state => {
  console.log("update result")
  // update result
  $('#match-result span').html(state.team1+":"+state.team2)
})
channel.on("end", state => {
  console.log("end game")
  $('#end-message').show()
})

var csrf = document.querySelector("meta[name=csrf]").content;

$(function() {
  $('#start-button').on('click', function() {
    $.ajax({
      url: '/start',
      type: 'POST',
      dataType: 'json',
      cache: false,
      headers: {
        "X-CSRF-TOKEN": csrf
      },
      complete: function() {},
      success: function(data) {
        console.log(data)
      },
      error: function(err) {
        console.error(err)
      }
    });
  });
})
