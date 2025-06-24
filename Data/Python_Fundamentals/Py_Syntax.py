#A single line comment

#Variables and Data Types
x = 5              # Integer
name = "Lucky"     # String
is_valid = True    # Boolean
pi = 3.14          # Float


#Indentation
#Python uses indentation (usually 4 spaces) to define blocks of code.
if x > 0:
    print("Positive number")


#Conditionals
if x > 0:
    print("Positive")
elif x == 0:
    print("Zero")
else:
    print("Negative")


#Loops
# While loop
i = 0
while i < 5:
    print(i)
    i += 1

# For loop
for i in range(5):
    print(i)


#Functions
def greet(name):
    return f"Hello, {name}" # string Interpolation

print(greet("Lucky"))


#Lists
fruits = ["apple", "banana", "cherry"]
print(fruits[0])       # Accessing the first item
fruits.append("Orange")  # Adding an item at the end of the list

# Looping through the list using an index
for i in range(len(fruits)):
    print(fruits[i])
#looping directly over the items
for fruit in fruits:
    print(fruit)


