# Part 1: Create a dictionary for a student
student = {"name": "Jose", "school": "Computing", "grades": (66, 77, 88)}

# Part 2: Modify grades variable in average_grade function
def average_grade(data):
    grades = data["grades"]
    return sum(grades) / len(grades)

# Part 3: Calculate average grade for a class
def average_grade_all_students(student_list):
    total = 0
    count = 0
    for student in student_list:
        total += sum(student["grades"])
        count += len(student["grades"])
    return total / count