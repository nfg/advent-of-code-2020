const fs = require('fs');
const target = 2020;


fs.readFile('input', {encoding: "UTF-8"}, (err, data) => {
  if (err) { throw err; }

  const nums = data.split("\n").map(ele => parseInt(ele));
  for(let i = 0; i < nums.length - 2; ++i) {
    for(let j = i + 1; j < nums.length - 1; ++j) {
      for(let k = j + 1; k < nums.length ; ++k) {
        if(nums[i] + nums[j] + nums[k] === target) {
          console.log(`Huzzah! ${nums[i]} * ${nums[j]} * ${nums[k]}`
            + ` = ${nums[i] * nums[j] * nums[k]}`);
          return;
        }
      }
    }
  }
  process.exitCode = 1;
  console.log(":(");
});
