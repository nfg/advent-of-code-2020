const fs = require('fs');
fs.readFile('input', {encoding: "UTF-8"}, (err, data) => {
  const lines = data.trimEnd().split("\n");
  const max = lines[0].length;

  const modes = [{right: 1, down: 1}, {right: 3, down: 1}, {right: 5, down: 1}, {right: 7, down: 1}, {right: 1, down: 2}];
  const product = modes.reduce((acc, args) => {
    const {down, right} = args;
    let row = 0, position = 0, count = 0;
    while(lines[row] !== undefined) {
      if (lines[row][position] === '#') { count++ }
      row += down;
      position = (position + right) % max;
    }
    console.log(`For right ${right} and down ${down}, the answer was ${count} trees`);
    return count * acc;
  }, 1); // Start acc at 1
  console.log(`PRODUCT: ${product}`);
});
