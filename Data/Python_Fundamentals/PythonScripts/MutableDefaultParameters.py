class Student:
    def __init__(self, name: str, grades: list[int] = []):  # mutable default list
        self.name = name
        self.grades = grades

    def take_exam(self, result: int):
        self.grades.append(result)

bob = Student("Bob")
bob.take_exam(90)
print(bob.grades)  # [90]

rolf = Student("Rolf")
print(rolf.grades)  # [90] — Oops! Shared grades list with Bob




#Corrected

from typing import Optional

class Student:
    def __init__(self, name: str, grades: Optional[list[int]] = None):
        self.name = name
        if grades is None:
            self.grades = []
        else:
            self.grades = grades

    def take_exam(self, result: int):
        self.grades.append(result)

bob = Student("Bob")
bob.take_exam(90)
print(bob.grades)  # [90]

rolf = Student("Rolf")
print(rolf.grades)  # [] — Now separate lists, no shared state
