def divide(dividend, divisor):
    if divisor == 0:
        raise ZeroDivisionError("Divisor cannot be zero.")
    return dividend / divisor

def calculate(*values, operator):
    return operator(*values)  # Calls the function with unpacked values

# Usage
result = calculate(20, 4, operator=divide)
print(result)  # Output: 5.0

def search(sequence, expected, finder):
    for elem in sequence:
        if finder(elem) == expected:
            return elem
    raise RuntimeError(f"Could not find an element with value {expected}")

friends = [
    {"name": "Rolf Smith", "age": 24},
    {"name": "Anne Brown", "age": 30}
]

def get_friend_name(friend):
    return friend["name"]

result = search(friends, "Rolf Smith", get_friend_name)
print(result)


# Replacing `get_friend_name` with a lambda:
result = search(friends, "Rolf Smith", lambda friend: friend["name"])

from operator import itemgetter

# Built-in function for extracting dictionary values
result = search(friends, "Rolf Smith", itemgetter("name"))

