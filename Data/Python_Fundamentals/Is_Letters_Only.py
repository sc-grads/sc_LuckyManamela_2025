def is_letters_only(text):
    return text.isalpha()

user_input = input("Enter something (letters only): ")

if is_letters_only(user_input):
    print("Valid input! You entered only letters.")
else:
    print("Invalid input. Please use letters only.")
