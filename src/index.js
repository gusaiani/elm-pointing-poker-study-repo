"use strict";

require("./sass/app.sass")
require("font-awesome/css/font-awesome.css")

// Require index.html so it gets copied to dist
require("./index.html")

// Initialize Firebase
var fb = firebase
    .initializeApp(require("../config.js"))
    .database();

// Embed Elm
var Elm = require("./Main.elm")
console.log("Elm", Elm);
var mountNode = document.getElementById("main")
var room = window.location.hash.substr(1)
var app = Elm.Main.embed(mountNode, {
  room: room
})

// Fetch Firebase data
var roomRef = null
app.ports.fbJoinRoom.subscribe(function(data) {
  if (roomRef) {
    roomRef.off();
  }

  roomRef = fb.ref("rooms/" + data.roomName)

  roomRef.on("value", function(snapshot) {
    if (snapshot.val()) {
      app.ports.receiveRoomData.send(snapshot.val())
    }
  })

  var amOnline = fb.ref(".info/connected");
  amOnline.on("value", function(snapshot) {
    if (snapshot.val()) {
      var userRef = roomRef.child("users").child(data.userName);
      userRef.onDisconnect().remove();
      userRef.set(0);
    }
  });
});

// Validate User Name
app.ports.checkIsNameAvailable.subscribe(function(data) {
  fb.ref("rooms")
    .child(data.roomName)
    .child("users")
    .child(data.userName)
    .once("value", function(snapshot) {
      var val = snapshot.val();
      const isNameAvailable = val === null
      app.ports.receiveIsNameAvailable.send(isNameAvailable);
    })
});

// Submit Vote
app.ports.fbVote.subscribe(function(data) {
  roomRef
    .child("users")
    .child(data.userName)
    .set(data.vote)
})

// Edit Room's Question
app.ports.fbEditQuestion.subscribe(function(question) {
  roomRef
    .child("question")
    .set(question)
})

