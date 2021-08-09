open Ink

let debugMode = true

type argv = array<string>
type process = {argv: argv}
@val external proc: process = "process"

type aliases = {h: string}
type parseArgsOpts = {
  boolean: array<string>,
  alias: aliases,
}
type parsedArgs = {
  @as("_") params: array<string>,
  help: bool,
}
@module external parseArgs: (argv, ~opts: parseArgsOpts=?, unit) => parsedArgs = "minimist"

module Debugger = {
  @react.component
  let make = (~args) =>
    switch debugMode {
    | true =>
      <Box display=#flex marginTop=6>
        <Text color=#red dimColor=true> {React.string("Debug Info")} </Text>
        <Text> {Js.Json.stringifyAny(args)->Belt.Option.getWithDefault("")->React.string} </Text>
      </Box>
    | false => React.null
    }
}

module Help = {
  @react.component
  let make = () =>
    <Box display=#flex flexDirection=#column justifyContent=#center>
      <Text bold=true> {React.string("GM Tools")} </Text>
      <Text bold=true color=#blue> {React.string("v0.0.1")} </Text>
      <Box display=#flex marginTop=1>
        <Text> {React.string("usage: gm-tools [--help] <command> [<args>]")} </Text>
      </Box>
      <Box display=#flex marginTop=2> <Text> {React.string("Common commands:")} </Text> </Box>
      <Box display=#flex flexDirection=#column marginTop=1>
        <Text> {React.string("Rolling dice")} </Text>
        <Box display=#flex justifyContent=#"flex-start">
          <Box display=#flex marginLeft=3 marginRight=4>
            <Text> {React.string("roll")} </Text>
          </Box>
          <Box display=#flex>
            <Text> {React.string("Roll arbitrary dice as a string.")} </Text>
          </Box>
        </Box>
      </Box>
    </Box>
}

module Main = {
  @react.component
  let make = (~args) => {
    let app = useApp()

    useInput((input, _) => {
      if input == 'q' {
        app.exit(None)
      }
    }, ())

    <Box
      display=#flex
      flexDirection=#column
      justifyContent=#center
      alignItems=#center
      width=#percent(1.0)
      height=#percent(1.0)>
      <Text> {React.string("Hello GM!")} </Text> <Debugger args />
    </Box>
  }
}

let args =
  proc.argv
  ->Belt.Array.sliceToEnd(2)
  ->parseArgs(
    ~opts={
      boolean: ["help"],
      alias: {
        h: "help",
      },
    },
    (),
  )

let showHelp = args.help || args.params[0]->Js.String2.toLowerCase == "help"

Js.Console.log2("Args", args)

let componentToRender = switch showHelp {
| true => <Help />
| false => <Main args />
}

let renderResult = render(componentToRender, ~exitOnCtrlC=true, ())
renderResult.waitUntilExit()->ignore
