a = [1, 2, 3]
b = a
print(id(a) == id(b))  # True, both names point to the same list object
a.append(4)
print(a)  # [1, 2, 3, 4]
print(b)  # [1, 2, 3, 4] — b reflects the change too, since it references the same object
