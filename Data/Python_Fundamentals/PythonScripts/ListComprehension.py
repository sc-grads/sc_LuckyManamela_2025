# Basic list comprehension: Doubling numbers
numbers = [1, 2, 3]
doubled = [x * 2 for x in numbers]
print(doubled)  # Outputs: [2, 4, 6]

# Traditional for loop equivalent
doubled = []
for num in numbers:
    doubled.append(num * 2)
print(doubled)  # Outputs: [2, 4, 6]

# List comprehension with condition: Names starting with 'S'
friends = ["Rolf", "Sam", "Samantha", "Saurabh", "Jen"]
starts_s = [friend for friend in friends if friend.startswith("S")]
print(starts_s)  # Outputs: ['Sam', 'Samantha', 'Saurabh']

# Traditional for loop equivalent
starts_s = []
for friend in friends:
    if friend.startswith("S"):
        starts_s.append(friend)
print(starts_s)  # Outputs: ['Sam', 'Samantha', 'Saurabh']

# Object identity
friends = ["Sam", "Samantha", "Saurabh"]
starts_s = [friend for friend in friends if friend.startswith("S")]
print(friends == starts_s)  # Outputs: True
print(friends is starts_s)  # Outputs: False
print(id(friends), id(starts_s))  # Outputs: Different memory addresses
print(friends[0] is starts_s[0])  # Outputs: True (due to string interning)

# Making lists identical
friends = ["Sam", "Samantha", "Saurabh"]
starts_s = friends
print(friends is starts_s)  # Outputs: True
print(id(friends), id(starts_s))  # Outputs: Same memory address