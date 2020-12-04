const fs = require('fs');
const util = require('util');

const field_regex = /^([^:]+):(.*)$/;

function parse_raw_password(raw_passport) {
  // Example passport data.
  //
  // ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
  // byr:1937 iyr:2017 cid:147 hgt:183cm
  const fields = raw_passport.split(/\s/).map(ele => {
    const found = ele.match(field_regex);
    if (! found) {
      throw Error(`Couldn't parse passport: ${raw_passport}`);
    }
    return [found[1], found[2]]; // [key, value].
  });
  return Object.fromEntries(fields);
}

//const required_fields = [ "ecl", "pid", "eyr", "hcl", "byr", "iyr", "cid", "hgt" ];
const required_fields = [ "ecl", "pid", "eyr", "hcl", "byr", "iyr", "hgt" ];
function solve_part_one(passports) {
  return passports.filter(passport => {
    let result = true;
    required_fields.forEach(field => {
      if (passport[field] === undefined) {
        result = false;
      }
    })
    return result;
  }).length;
}

fs.readFile('input', {encoding: "UTF-8"}, (err, data) => {
  if (err) { throw err }


  const passports = data.trimEnd().split("\n\n").map(parse_raw_password);

  console.log(`Answer to part one: ${solve_part_one(passports)}`);
});
