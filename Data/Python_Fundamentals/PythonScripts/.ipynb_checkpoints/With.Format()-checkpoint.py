# F-String Example
name = "Bob"
greeting = f"Hello, {name}"
print(greeting)  # Outputs: Hello, Bob

name = "Rolf"
print(greeting)  # Outputs: Hello, Bob (unchanged)
print(f"Hello, {name}")  # Outputs: Hello, Rolf

# .format() Example
name = "Bob"
greeting = "Hello, {}"
with_name = greeting.format(name)
print(with_name)  # Outputs: Hello, Bob

name = "Rolf"
with_name = greeting.format(name)
print(with_name)  # Outputs: Hello, Rolf

# .format() with Multiple Placeholders
template = "Hello, {}. Today is {}."
result = template.format("Rolf", "Monday")
print(result)  # Outputs: Hello, Rolf. Today is Monday.