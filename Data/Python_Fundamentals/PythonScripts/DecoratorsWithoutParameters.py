def make_secure(func):
    def secure_function():
        if user["access_level"] == "admin":
            return func()
        else:
            return "No admin permissions."
    return secure_function

@make_secure
def get_password(panel):
    if panel == "admin":
        return "1234"
    elif panel == "billing":
        return "super_secure_password"
