#!/usr/local/bin/node
const fs = require("fs");
const prependFile = require("prepend-file");

const ENTRYPOINT = `${__dirname}/src/Main.bs.js`;

(async () => {
  try {
    const currentFileContents = await fs.promises.readFile(ENTRYPOINT, "utf-8");
    if (currentFileContents.slice(0, 22) === "#!/usr/local/bin/node\n") {
      console.log("No need to add shebang");
      return;
    }
    await prependFile(ENTRYPOINT, "#!/usr/local/bin/node\n");
    console.log("File prepended with shebang");
  } catch (err) {
    console.error(err);
  }
})();
