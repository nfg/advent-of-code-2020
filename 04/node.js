const fs = require('fs');

const passport_fields = [
  {
    name: "byr", // Birth Year
    required: true,
    validation: val => Number.parseInt(val) && val >= 1920 && val <= 2002
  },
  {
    name: "iyr", // Issue Year
    required: true,
    validation: val => Number.parseInt(val) && val >= 2010 && val <= 2020
  },
  {
    name: "eyr", // Expiration Year
    required: true,
    validation: val => Number.parseInt(val) && val >= 2020 && val <= 2030
  },
  {
    name: "hgt", // Height
    required: true,
    validation: val => {
      const matched = val.match(/(\d+)(cm|in)/);
      if (! matched) { return false; }
      if (matched[2] === 'cm') {
        return matched[1] >= 150 && matched[1] <= 193;
      }
      return matched[1] >= 59 && matched[1] <= 76;
    },
  },
  {
    name: "hcl", // Hair Colour
    required: true,
    // a # followed by exactly six characters 0-9 or a-f.
    validation: val => Boolean(val.match(/^#[0-9a-f]{6}$/)) 
  },
  {
    name: "ecl", // Eye Colour
    required: true,
    validation: val => ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']
      .filter(ele => val === ele)
      .length === 1
  },
  {
    name: "pid", // Passport ID
    required: true,
    validation: val => Boolean(val.match(/^\d{9}$/))
  },
  {
    name: "cid", // Country ID
    required: false,
    validation: val => true
  }
];

function parse_raw_password(raw_passport) {
  // Example passport data.
  //
  // ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
  // byr:1937 iyr:2017 cid:147 hgt:183cm
  return raw_passport.split(/\s/).reduce((acc, ele) => {
    const found = ele.match(/^([^:]+):(.*)$/);
    if (! found) {
      throw Error(`Couldn't parse passport: ${raw_passport}`);
    }
    acc[found[1]] = found[2]
    return acc;
  },{}); // acc = object
}

function solve(passports, do_validation) {
  return passports.filter(passport => {
    let result = true;
    for ({name, required, validation} of passport_fields) {
      let value = passport[name];
      if (required && value === undefined) {
        return false;
      }
      if (do_validation && ! validation(value)) {
        return false;
      }
    }
    return true;
  }).length
}

fs.readFile('input', {encoding: "UTF-8"}, (err, data) => {
  if (err) { throw err }

  const passports = data.trimEnd().split("\n\n").map(parse_raw_password);
  console.log(`Answer to part one: ${solve(passports, false)}`);
  console.log(`Answer to part two: ${solve(passports, true)}`);
});
