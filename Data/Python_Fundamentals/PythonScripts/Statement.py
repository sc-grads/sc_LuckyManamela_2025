# Basic if statement
day_of_week = input("What day of the week is it today? ")
if day_of_week == "Monday":
    print("Have a great start to your week!")
print("This always runs.")

# If-else statement
day_of_week = input("What day of the week is it today? ")
if day_of_week == "Monday":
    print("Have a great start to your week!")
else:
    print("Full speed ahead!")

# If-elif-else chain
day_of_week = input("What day of the week is it today? ")
if day_of_week == "Monday":
    print("Have a great start to your week!")
elif day_of_week == "Tuesday":
    print("It's Tuesday, keep going!")
else:
    print("Full speed ahead!")

# Handling case sensitivity
day_of_week = input("What day of the week is it today? ").lower()
if day_of_week == "monday":
    print("Have a great start to your week!")
else:
    print("Full speed ahead!")