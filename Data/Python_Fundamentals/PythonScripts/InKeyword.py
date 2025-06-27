# Checking membership in a list
friends = ["Rolf", "Bob", "Jen"]
print("Jen" in friends)  # Outputs: True
print("Anne" in friends)  # Outputs: False

# Checking membership in a set with user input
movies_watched = {"The Matrix", "Inception", "The Lord of the Rings"}
user_movie = input("Enter a movie you've watched recently: ")
print(user_movie in movies_watched)
# Outputs: True for "The Matrix", False for "Monty Python"

# Checking substring in a string
movie = "The Matrix"
print("rix" in movie)  # Outputs: True
print("xyz" in movie)  # Outputs: False