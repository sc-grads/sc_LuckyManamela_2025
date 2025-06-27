# While loop: Magic number game (condition-based)
number = 7
user_input = input("Would you like to play? (Y/n) ")
while user_input != "n":
    user_number = int(input("Guess our number: "))
    if user_number == number:
        print("You guessed correctly!")
    else:
        print("Sorry, it's wrong.")
    user_input = input("Would you like to play? (Y/n) ")

# While loop: Magic number game (using break)
number = 7
while True:
    user_input = input("Would you like to play? (Y/n) ")
    if user_input == "n":
        break
    user_number = int(input("Guess our number: "))
    if user_number == number:
        print("You guessed correctly!")
    else:
        print("Sorry, it's wrong.")

# For loop: Printing friends
friends = ["Rolf", "Jen", "Bob", "Anne"]
for friend in friends:
    print(f"{friend} is my friend.")

# For loop: Using range
for i in range(4):
    print(f"{i} is my friend.")

# For loop: Calculating average
grades = [35, 67, 98, 100, 100]
total = 0
amount = len(grades)
for grade in grades:
    total += grade
print(total / amount)  # Outputs: 80.0

# Alternative: Using sum()
grades = [35, 67, 98, 100, 100]
total = sum(grades)
amount = len(grades)
print(total / amount)  # Outputs: 80.0