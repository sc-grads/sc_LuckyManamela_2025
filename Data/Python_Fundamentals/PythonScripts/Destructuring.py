# Basic destructuring
x, y = 5, 11
print(x, y)  # Outputs: 5 11

t = (5, 11)
x, y = t
print(x, y)  # Outputs: 5 11

# Destructuring in dictionary .items()
student_attendance = {"Rolf": 96, "Bob": 80, "Anne": 100}
print(list(student_attendance.items()))  # Outputs: [('Rolf', 96), ('Bob', 80), ('Anne', 100)]
for t in student_attendance.items():
    print(t)  # Outputs: ('Rolf', 96), ('Bob', 80), ('Anne', 100)
for student, attendance in student_attendance.items():
    print(f"{student}: {attendance}%")  # Outputs: Rolf: 96%, Bob: 80%, Anne: 100%

# Destructuring list of tuples
people = [("Bob", 42, "Mechanic"), ("James", 24, "Artist"), ("Harry", 32, "Lecturer")]
for name, age, profession in people:
    print(f"Name: {name}, Age: {age}, Profession: {profession}")
# Outputs:
# Name: Bob, Age: 42, Profession: Mechanic
# Name: James, Age: 24, Profession: Artist
# Name: Harry, Age: 32, Profession: Lecturer

# Error case
# people = [("Bob", 42, "Mechanic"), ("Mary", 22)]  # ValueError: not enough values to unpack

# Without destructuring (less readable)
for person in people:
    print(f"Name: {person[0]}, Age: {person[1]}, Profession: {person[2]}")

# Ignoring values with underscore
person = ("Bob", 42, "Mechanic")
name, _, profession = person
print(name, profession)  # Outputs: Bob Mechanic

# Collecting with asterisk
numbers = [1, 2, 3, 4, 5]
head, *tail = numbers
print(head, tail)  # Outputs: 1 [2, 3, 4, 5]
*head, tail = numbers
print(head, tail)  # Outputs: [1, 2, 3, 4] 5