user = {"username": "Lucky", "access_level": "guest"}

import functools

def make_secure(func):
    @functools.wraps(func)
    def secure_function():
        if user["access_level"] == "admin":
            return func()
        return f"No admin permissions for {user['username']}."
    return secure_function

@make_secure
def get_admin_password():
    """Returns the admin password."""
    return "1234"
