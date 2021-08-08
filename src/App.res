open Ink

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
  help: option<bool>,
}
@module external parseArgs: (argv, ~opts: parseArgsOpts=?, unit) => parsedArgs = "minimist"

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
  let make = () => {
    let app = useApp()

    useInput((input, _) => {
      if input == 'q' {
        app.exit(None)
      }
    }, ())

    <Box display=#flex justifyContent=#center> <Text> {React.string("Hello GM!")} </Text> </Box>
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

let componentToRender = switch args.help {
| Some(true) => <Help />
| Some(false)
| None =>
  <Main />
}

Js.Console.log(args.params)

let renderResult = render(componentToRender, ~exitOnCtrlC=true, ())
renderResult.waitUntilExit()->ignore
