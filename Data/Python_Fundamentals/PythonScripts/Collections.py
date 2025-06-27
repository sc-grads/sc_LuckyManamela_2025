# Defining collections
l = ["Bob", "Rolf", "Anne"]  # List
t = ("Bob", "Rolf", "Anne")  # Tuple
s = {"Bob", "Rolf", "Anne"}  # Set

# Accessing elements (lists and tuples)
print(l[0])  # Outputs: Bob
print(t[2])  # Outputs: Anne
# print(s[0])  # Error: 'set' object is not subscriptable

# Modifying a list
l[0] = "Smith"
print(l)  # Outputs: ['Smith', 'Rolf', 'Anne']

# Adding to a list
l.append("Smith")
print(l)  # Outputs: ['Smith', 'Rolf', 'Anne', 'Smith']

# Removing from a list
l.remove("Rolf")
print(l)  # Outputs: ['Smith', 'Anne', 'Smith']

# Adding to a set
s.add("Smith")
print(s)  # Outputs: {'Anne', 'Bob', 'Smith', 'Rolf'} (order may vary)
s.add("Smith")  # No effect (duplicates ignored)
print(s)  # Outputs: {'Anne', 'Bob', 'Smith', 'Rolf'}

# Attempting to modify a tuple (will raise errors)
# t[0] = "Smith"  # Error: TypeError
# t.append("Smith")  # Error: AttributeError