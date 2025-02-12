
local adult_age = 18;

local createPerson(name, age, hobbies) = {
  name: name,
  age: age,
  hobbies: hobbies,
  isAdult: age >= adult_age,
  introduction: "Hi, I'm " + name + " and I'm " + age + " years old.",
};

// Function to calculate the average age of a list of people
local averageAge(people) =
  local ages = [p.age for p in people];
  std.sum(ages) / std.length(ages);

// Main code
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
    adultAge: adult_age,
    veryOldAdult: self.adultAge + 100,
  },
}
