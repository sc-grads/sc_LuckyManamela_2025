# Numeric comparisons
print(5 == 5)  # Outputs: True
print(5 > 10)  # Outputs: False
print(10 != 10)  # Outputs: False
print(5 < 10)  # Outputs: True
print(5 >= 5)  # Outputs: True
print(5 <= 3)  # Outputs: False

# List comparisons with == and is
friends = ["Bob", "Rolf", "Anne"]
abroad = ["Bob", "Rolf", "Anne"]
print(friends == abroad)  # Outputs: True (same elements)
print(friends is abroad)  # Outputs: False (different objects)

# Same object comparison
abroad = friends
print(friends is abroad)  # Outputs: True (same object)