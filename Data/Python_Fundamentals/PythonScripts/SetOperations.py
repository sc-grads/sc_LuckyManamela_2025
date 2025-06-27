# Difference: Finding local friends
friends = {"Bob", "Rolf", "Anne"}
abroad = {"Bob", "Anne"}
local = friends.difference(abroad)
print(local)  # Outputs: {'Rolf'}

# Reverse difference: Empty set
local = abroad.difference(friends)
print(local)  # Outputs: set()

# Union: Combining local and abroad friends
local = {"Rolf"}
abroad = {"Bob", "Anne"}
friends = local.union(abroad)
print(friends)  # Outputs: {'Rolf', 'Bob', 'Anne'} (order may vary)

# Intersection: Finding students studying both art and science
art = {"Bob", "Jen", "Rolf", "Charlie"}
science = {"Bob", "Jen", "Adam", "Anne"}
both = art.intersection(science)
print(both)  # Outputs: {'Bob', 'Jen'}