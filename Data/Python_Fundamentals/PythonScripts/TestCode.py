# Dictionary-based
student = {"name": "Jose", "school": "Computing", "grades": (66, 77, 88)}
print(average_grade(student))  # 77.0
student_list = [student, {"name": "Bob", "school": "Math", "grades": (80, 100)}]
print(average_grade_all_students(student_list))  # 82.2
# OOP-based
class Student:
    def __init__(self, name, school, grades):
        self.name = name
        self.school = school
        self.grades = grades
    def average_grade(self):
        return sum(self.grades) / len(self.grades) if self.grades else 0
    def __str__(self):
        return f"{self.name}, {self.school}, Grades: {self.grades}"
    def __repr__(self):
        return f"Student(name='{self.name}', school='{self.school}', grades={self.grades})"
student_obj = Student("Jose", "Computing", (66, 77, 88))
print(student_obj)  # Jose, Computing, Grades: (66, 77, 88)
print(repr(student_obj))  # Student(name='Jose', school='Computing', grades=(66, 77, 88))
print(student_obj.average_grade())  # 77.0
print(average_grade_all_students([student_obj, Student("Bob", "Math", (80, 100))]))  # 82.2