# Basic input example: Getting a name
name = input("Enter your name: ")
print(name)  # Outputs the entered name, e.g., Rolf

# Converting input to a number for math
size_input = input("Enter the size of your house (in square feet): ")
square_feet = float(size_input)  # Convert string to float
square_meters = square_feet / 10.8  # Convert to square meters
print(square_meters)  # Outputs: 46.2962962962963 (for input 500)

# Challenge: Nicer output with formatted f-string
print(f"{square_feet} square feet is {square_meters:.2f} square meters")
# Outputs: 500 square feet is 46.30 square meters (for input 500)