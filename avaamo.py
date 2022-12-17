x = 0
y = 0
z = ""
for i in range(1,101):
    x = x+1
    y = y+1
    if(x == 3):
        z = z + "ava"
        x = 0
    if(y == 5):
        z = z + "amo"
        y = 0
    if(z == ""):
        print(i)
    else:
        print(z)
    z = ""
