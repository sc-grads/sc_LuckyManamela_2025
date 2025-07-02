user = {
    "username": "Lucky",
    "access_level": "guest"  # or "admin"
}

def get_admin_password():
    return "1234"


def make_secure(func):
    def secure_function():
        if user["access_level"] == "admin":
            return func()
        else:
            return f"No admin permissions for {user['username']}."
    return secure_function
