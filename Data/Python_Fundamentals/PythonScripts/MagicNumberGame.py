# Movie watching check with in and if
movies_watched = {"The Matrix", "Inception", "The Lord of the Rings"}
user_movie = input("Enter a movie you've watched recently: ")
if user_movie in movies_watched:
    print(f"I've watched {user_movie} too!")
else:
    print("I haven't watched that yet.")

# Magic number game (basic)
number = 7
user_input = input("Enter Y if you would like to play: ")
if user_input == "Y":
    user_number = int(input("Guess our number: "))
    if user_number == number:
        print("You guessed correctly!")
    else:
        print("Sorry, it's wrong.")

# Magic number game with case-insensitive input
number = 7
user_input = input("Enter Y if you would like to play: ").lower()
if user_input == "y":
    user_number = int(input("Guess our number: "))
    if user_number == number:
        print("You guessed correctly!")
    else:
        print("Sorry, it's wrong.")

# Magic number game with proximity hint using in
number = 7
user_input = input("Enter Y if you would like to play: ").lower()
if user_input == "y":
    user_number = int(input("Guess our number: "))
    if user_number == number:
        print("You guessed correctly!")
    elif (number - user_number) in (1, -1):
        print("You were off by one.")
    else:
        print("Sorry, it's wrong.")

# Magic number game with proximity hint using abs (preferred)
number = 7
user_input = input("Enter Y if you would like to play: ").lower()
if user_input == "y":
    user_number = int(input("Guess our number: "))
    if user_number == number:
        print("You guessed correctly!")
    elif abs(number - user_number) == 1:
        print("You were off by one.")
    else:
        print("Sorry, it's wrong.")