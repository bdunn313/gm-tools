// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Ink = require("rescript-ink/src/Ink.bs.js");
var Ink$1 = require("ink");
var Curry = require("rescript/lib/js/curry.js");
var React = require("react");
var Caml_option = require("rescript/lib/js/caml_option.js");
var Ink_Components_Box = require("rescript-ink/src/Ink_Components_Box.bs.js");
var Ink_Components_Text = require("rescript-ink/src/Ink_Components_Text.bs.js");

function Main$Main(Props) {
  var app = Ink.useApp(undefined);
  Ink.useInput((function (input, param) {
          if (input === /* 'q' */113) {
            return Curry._1(app.exit, undefined);
          }
          
        }), undefined, undefined);
  return React.createElement(Ink$1.Box, Ink_Components_Box.makeProps(undefined, Caml_option.some(React.createElement(Ink$1.Text, Ink_Components_Text.makeProps(undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "Hello GM!", undefined))), "flex", undefined, undefined, undefined, undefined, undefined, "center", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined));
}

var Main = {
  make: Main$Main
};

var match = Ink.render(React.createElement(Main$Main, {}), undefined, true, undefined, undefined);

var waitUntilExit = match.waitUntilExit;

Curry._1(waitUntilExit, undefined);

exports.Main = Main;
exports.waitUntilExit = waitUntilExit;
/* match Not a pure module */
