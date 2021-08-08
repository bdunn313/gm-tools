module Main = {
  @react.component
  let make = () => {
    let app = Ink.useApp()

    Ink.useInput((input, _) => {
      if input == 'q' {
        app.exit(None)
      }
    }, ())

    <Ink.Box display=#flex justifyContent=#center>
      <Ink.Text> {React.string("Hello GM!")} </Ink.Text>
    </Ink.Box>
  }
}

let renderResult = Ink.render(<Main />, ~exitOnCtrlC=true, ())
renderResult.waitUntilExit()->ignore
