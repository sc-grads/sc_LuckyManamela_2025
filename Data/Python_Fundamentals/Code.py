import sys

def welcome_message() -> None:
    print("Welcome to Groceries")
    print("Enter 1 to add an item, 2 to remove an item, 3 to list all items, 0 to exit")

def add_item(item: str, groceries: list[str]) -> None:
    groceries.append(item)
    print(f"{item} has been added")

def remove_item(item: str, groceries: list[str]) -> None:
    try:
        groceries.remove(item)
        print(f"{item} has been removed")
    except ValueError:
        print(f"No {item} found in groceries")

def display(groceries: list[str]) -> None:
    print("___LIST___")
    for i, item in enumerate(groceries, start=1):
        print(f"{i}: {item.capitalize()}")
    print("__________")

def is_valid_option(user_input: str) -> bool:
    return user_input in ["1", "2", "3", "0"]

if __name__ == "__main__":
    groceries: list[str] = []
    welcome_message()
    while True:
        user_input: str = input("Choose an option: ").lower()
        if not is_valid_option(user_input):
            print("Please pick a valid option...")
            continue
        if user_input == "1":
            item = input("What item would you like to add? ").lower()
            add_item(item, groceries)
        elif user_input == "2":
            item = input("What item would you like to remove? ").lower()
            remove_item(item, groceries)
        elif user_input == "3":
            display(groceries)
        elif user_input == "0":
            print("Exiting the program")
            sys.exit()