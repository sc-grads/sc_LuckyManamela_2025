user = {"username": "Anna", "access_level": 2}  # 0=guest, 1=user, 2=admin

def make_secure(access_level):
    def decorator(func):
        @functools.wraps(func)
        def secure_function(*args, **kwargs):
            if user["access_level"] >= access_level:
                return func(*args, **kwargs)
            else:
                return f"No permissions for {user['username']}."
        return secure_function
    return decorator

@make_secure(2)  # admin
def get_admin_password():
    return "1234"

@make_secure(1)  # user
def get_dashboard_password():
    return "dashboard_password"

print(get_admin_password())       # 1234
print(get_dashboard_password())   # dashboard_password
