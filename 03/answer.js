const fs = require('fs');
fs.readFile('input', {encoding: "UTF-8"}, (err, data) => {
  const lines = data.trimEnd().split("\n");
  const max = lines[0].length;
  const result = lines.reduce((acc, line) => {
    if (line[acc.position] === '#') { acc.count++ }
    acc.position = (acc.position + 3) % max;
    return acc;
  }, {count: 0, position: 0}).count;
  console.log(`FOUND: ${result}`);
});
