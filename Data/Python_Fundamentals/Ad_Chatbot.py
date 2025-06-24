import re
import random

# Dictionary of patterns and responses
patterns = {
    r"hi|hello|hey": ["Hello!", "Hi there!", "Hey! How can I assist you?"],
    r"how are you": ["I'm doing well, thank you!", "All good! How about you?"],
    r"(.*) your name": ["I’m ChatBot, your virtual assistant."],
    r"(.*) help (.*)": ["Sure! What do you need help with?", "I'm here to help. Ask me anything!"],
    r"bye|exit|quit": ["Goodbye!", "See you later!", "Take care!"]
}

# Fallback response
fallback = "I'm not sure how to respond to that. Try asking something else."

def get_response(user_input):
    for pattern, responses in patterns.items():
        if re.search(pattern, user_input.lower()):
            return random.choice(responses)
    return fallback

# Chat loop
print("ChatBot: Hello! Type 'bye' to exit.")
while True:
    user_input = input("You: ")
    response = get_response(user_input)
    print(f"ChatBot: {response}")
    if re.search(r"bye|exit|quit", user_input.lower()):
        break
