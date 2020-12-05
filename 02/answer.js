const fs = require('fs');

function policy1 (min, max, char, password) {
  const count = password.split('').filter(ele => ele === char).length;
  return count >= min && count <= max;
}

function policy2 (pos1, pos2, char, password) {
  // Note: They index at one, not zero.
  return Boolean(password[pos1-1] === char) != Boolean(password[pos2-1] === char);
}

fs.readFile('input', {encoding: "UTF-8"}, (err, data) => {
  if (err) { throw err; }
  const regex = /^(\d+)-(\d+) (.): (.*)$/;
  const parsed_lines = data.split("\n")
    .filter(line => line !== '')
    .map(line => {
      const match = line.match(regex);
      if (!match) {
        throw new Error(`Couldn't parse line: ${line}`);
      }
      return match.splice(1);
    });

  console.log(`Part one: ${parsed_lines.filter(args => policy1(...args)).length}`);
  console.log(`Part two: ${parsed_lines.filter(args => policy2(...args)).length}`);
});
