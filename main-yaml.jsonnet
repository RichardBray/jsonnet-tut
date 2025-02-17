// Define the createPerson function
local createPerson(name, age, hobbies) = {
  name: name,
  age: age,
  hobbies: hobbies,
  isAdult: age >= 18,
};

// Function to calculate the average age of a list of people
local averageAge(people) =
  local ages = [p.age for p in people];
  std.sum(ages) / std.length(ages);

// Main code wrapped in an array
[
  {
    people: [
      createPerson("Alice", 25, ["reading", "hiking"]),
      createPerson("Bob", 17, ["gaming", "swimming"]),
      createPerson("Charlie", 30, ["cooking", "traveling"]),
    ],
    stats: {
      totalPeople: std.length($.people),
      averageAge: averageAge($.people),
      adultCount: std.length([p for p in $.people if p.isAdult]),
      adultAge: 18,
      veryOldAdult: 118,
    },
  }
]