open Ink

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

let renderResult = render(<Main />, ~exitOnCtrlC=true, ())
renderResult.waitUntilExit()->ignore
