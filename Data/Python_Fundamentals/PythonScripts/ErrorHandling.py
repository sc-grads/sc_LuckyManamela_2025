grades = []

try:
    average = divide(sum(grades), len(grades))
except ZeroDivisionError as e:
    print("There are no grades yet in your list.")
    print(e)  # Optional, prints: Divisor cannot be zero
else:
    print(f"The average grade is {average}")
finally:
    print("Finished processing grades.")

raise TypeError("Expected a string")
raise ValueError("Invalid grade")
