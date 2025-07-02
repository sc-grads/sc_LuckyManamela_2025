import functools
# Simulated user data
user = {"username": "Jose", "access_level": "guest"}

def make_secure(access_level):
    """
    Decorator factory that creates a decorator checking user's access level.
    """
    def decorator(func):
        @functools.wraps(func)
        def secure_function(*args, **kwargs):
            if user["access_level"] == access_level:
                return func(*args, **kwargs)
            else:
                return f"No {access_level} permissions for {user['username']}."
        return secure_function
    return decorator

@make_secure("admin")
def get_admin_password():
    return "1234"

@make_secure("user")
def get_dashboard_password():
    return "dashboard_password"

# Testing the decorator with different users:

print(get_admin_password())       # No admin permissions for Jose.
print(get_dashboard_password())   # No user permissions for Jose.

# Change user to admin
user["username"] = "Anna"
user["access_level"] = "admin"

print(get_admin_password())       # 1234
print(get_dashboard_password())   # No user permissions for Anna (because her access_level is "admin", not "user")
