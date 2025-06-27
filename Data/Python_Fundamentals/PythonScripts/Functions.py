# Simple function
def hello():
    print("Hello!")

hello()  # Outputs: Hello!

# Age in seconds calculator
def user_age_in_seconds():
    user_age = int(input("Enter your age: "))
    age_in_seconds = user_age * 365 * 24 * 60 * 60
    print(f"Your age in seconds is {age_in_seconds}.")

print("Welcome to the age in seconds programme!")
user_age_in_seconds()
print("Goodbye!")
# Outputs (e.g., for input 30):
# Welcome to the age in seconds programme!
# Enter your age: 30
# Your age in seconds is 946080000.
# Goodbye!

# Pitfall: Shadowing built-in function
def print():  # Avoid this
    print("Hello World")
# print("Hello World")  # TypeError

# Pitfall: Shadowing variable
friends = ["Rolf", "Bob"]
def add_friend():
    friend_name = input("Enter friend name: ")
    # friends = friends + [friend_name]  # UnboundLocalError
    f = friends + [friend_name]  # Correct: Use different variable
    print(f)
# add_friend()

# Modifying global variable
def add_friend():
    friends.append("Rolf")

friends = ["Bob"]
add_friend()
print(friends)  # Outputs: ['Bob', 'Rolf']
