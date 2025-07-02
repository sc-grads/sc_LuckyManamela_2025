def make_secure(func):
    def secure_function(*args, **kwargs):
        if user["access_level"] == "admin":
            return func(*args, **kwargs)
        else:
            return "No admin permissions."
    return secure_function

@make_secure
def get_password(panel):
    if panel == "admin":
        return "1234"
    elif panel == "billing":
        return "super_secure_password"

# Example usage
user = {"username": "Lucky", "access_level": "admin"}

print(get_password("billing"))  # Output: super_secure_password
