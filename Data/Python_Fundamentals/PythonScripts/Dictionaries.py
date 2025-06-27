# Creating and accessing a dictionary
friend_ages = {"Rolf": 24, "Adam": 30, "Anne": 27}
print(friend_ages["Adam"])  # Outputs: 30

# Adding and modifying entries
friend_ages["Bob"] = 20
print(friend_ages)  # Outputs: {'Rolf': 24, 'Adam': 30, 'Anne': 27, 'Bob': 20}
friend_ages["Rolf"] = 20
print(friend_ages)  # Outputs: {'Rolf': 20, 'Adam': 30, 'Anne': 27, 'Bob': 20}

# List of dictionaries
friends = [
    {"name": "Rolf", "age": 24},
    {"name": "Adam", "age": 30},
    {"name": "Anne", "age": 27}
]
print(friends)  # Outputs: [{'name': 'Rolf', 'age': 24}, {'name': 'Adam', 'age': 30}, {'name': 'Anne', 'age': 27}]
print(friends[1]["name"])  # Outputs: Adam

# Iterating over a dictionary (keys)
student_attendance = {"Rolf": 96, "Bob": 80, "Anne": 100}
for student in student_attendance:
    print(f"{student}: {student_attendance[student]}%")
# Outputs:
# Rolf: 96%
# Bob: 80%
# Anne: 100%

# Iterating with items()
for student, attendance in student_attendance.items():
    print(f"{student}: {attendance}%")
# Outputs: Same as above

# Using in keyword
if "Bob" in student_attendance:
    print(f"Bob attended {student_attendance['Bob']}% of lectures")
else:
    print("Bob is not a student in this class")
# Outputs: Bob attended 80% of lectures

# Using values() for average
attendance_values = student_attendance.values()
print(sum(attendance_values) / len(attendance_values))  # Outputs: 92.0