students = [
    {"name": "Bob", "grades": [90, 75]},
    {"name": "Rolf", "grades": []},
    {"name": "Jen", "grades": [100, 80]},
]

for student in students:
    try:
        avg = divide(sum(student["grades"]), len(student["grades"]))
    except ZeroDivisionError:
        print(f"Error: {student['name']} has no grades.")
    else:
        print(f"{student['name']}'s average: {avg}")
    finally:
        print("Finished processing this student.\n")
