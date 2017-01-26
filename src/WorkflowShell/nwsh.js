const fs = require('fs');
const path = require('path');
const argv = require('minimist')(process.argv.slice(2));

// From applegrain
// https://gist.github.com/kethinov/6658166
const walkSync = (dir, inputFileList = []) => {
  let fileList = inputFileList;
  fs.readdirSync(dir).forEach((file) => {
    fileList = fs.statSync(path.join(dir, file)).isDirectory()
      ? walkSync(path.join(dir, file), fileList)
      : fileList.concat(path.join(dir, file));
  });
  return fileList;
};

// Keep track of commands we've found, in case we don't find what we're looking for.
let foundCommand = false;
const foundCommands = [];
const workingDirectory = __dirname;
const desiredCommand = argv._.shift();
walkSync(workingDirectory, []).forEach((filePath) => {
  if (!foundCommand &&
    filePath.indexOf('Command.js') < 0 &&
    filePath.indexOf('TPLinkUtil.js') < 0 &&
    filePath.indexOf('nwsh.js') < 0 &&
    filePath.indexOf('.js') > -1) {
    try {
      // Try to require the class
      const ClassObject = require(filePath);
      // If it's the right one, instantiate it and run it
      if (desiredCommand === ClassObject.getString()) {
        const commandInstance = new ClassObject();
        commandInstance.run(argv);
        foundCommand = true;
      } else {
        // Otherwise, take note of it
        foundCommands.push(`${ClassObject.getString()}\t${ClassObject.getDescription()}`);
      }
    } catch (error) {
      console.log(`Problem occurred while trying to instantiate '${filePath}'`);
      console.log(`Error: ${error}`);
    }
  }
});

// No commands matched... print out the available ones.
if (!foundCommand && typeof foundCommands !== 'undefined' && foundCommands.length > 0) {
  console.log(`Unknown command specified: ${desiredCommand}`);
  foundCommands.forEach((command) => {
    console.log(`${command}`);
  });
}
