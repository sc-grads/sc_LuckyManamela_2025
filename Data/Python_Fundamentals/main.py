import greetings

greetings.greet("Mario")
print(greetings.AUTHOR)

import greetings as g

g.greet("Mario")
print(g.AUTHOR)

from greetings import greet

greet("Mario")
# print(AUTHOR)  # This would cause a NameError

from greetings import *

greet("Luigi")
print(AUTHOR)
print(VERSION)