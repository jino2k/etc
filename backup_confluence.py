import os
from datetime import date


path = os.getcwd()
print(path)

today = date.today()
print("Today's date:", today)

# try:
#     os.mkdir(path)
# except OSError:
#     print ("Creation of the directory %s failed" % path)
# else:
#     print ("Successfully created the directory %s " % path)