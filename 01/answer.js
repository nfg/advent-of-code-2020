const fs = require('fs');
const target = 2020;

fs.readFile('input', {encoding: "UTF-8"}, (err, data) => {
  if (err) { throw err; }
  const lines = data.split("\n").map(ele => parseInt(ele));
  while (lines.length > 1) {
    const head = lines.shift();
    for (const val of lines) {
      if (head + val === target) {
        console.log(`Found it! ${head} * ${val} = ${head * val}`);
        return;
      }
    }
  }
  process.exitCode = 1;
  console.log(":(");
});
