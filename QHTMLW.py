#TODO: this program is redundancy hell, clean this up
#TODO: this program is redundancy hell, clean this up
#TODO: this program is redundancy hell, clean this up

import os
from sys import platform

def main():
    if (platform != "win32"):
        import readline
        clear = ("clear")
    else:
        clear = ("cls")

    counter = 0
    filename = get_input("Insert the filename of the file you want to create (omit .HTML suffix in title): ", clear)
    filename = (filename + ".html")
    filename = filename.replace(" ", "")
    filename = filename.lower()

    if (os.path.isfile(filename) == True):
        print("ERROR: File exists")
        quit()
    else:
        f = open(filename, "w")
        f.write("<html>\n")
        f.write("<head>\n\n")
        f.write("<title>" + filename + "</title>")
        f.write("</head>\n\n")
        f.write("<body>\n")
        f.close()

    while True:
        print("Number of additions this session: ", counter, "\n")
        while True:
            user_input = get_input("h) Create a header\np) Create a paragraph\nl) Create a hyperlink\ni) Create an image\n\nq) Quit: \n\n", clear)
            if (user_input != ""):
                if ((user_input == "h") or (user_input == "p") or (user_input == "l") or (user_input == "i")):
                    break
                elif (user_input == "q"):
                    break
                else:
                    print("Choice does not exist")
            else:
                print("Entry cannot be blank")
        message = ("Input the text you want to use in the section: ")
        if (user_input == "h"):
            choice = 1

            while True:
                user_input = get_input("1) Create a h1 title\n2) Create a h2 title\n3) Create a h3 title\n\nq) Quit\n", clear)
                if (user_input != ""):
                    if ((user_input >= "1") and (user_input <= "3")):
                        break
                    elif (user_input == "q"):
                        break
                    else:
                        print("Choice does not exist")
                else:
                    print("Entry cannot be blank")

            if (user_input == "1"):
                title = ("")
                open_tag = ("<h1>")
                close_tag = ("</h1>")
            elif (user_input == "2"):
                title = ("")
                open_tag = ("<h2>")
                close_tag = ("</h2>")
            else:
                title = ("")
                open_tag = ("<h3>")
                close_tag = ("</h3>")
        elif (user_input == "p"):
            choice = (1)
            title = ("")
            open_tag = ("<p>")
            close_tag = ("</p>")
        elif (user_input == "i"):
            choice = (1)
            title = ("")
            message = ("Insert the path to image (ex: ./images/photo.png): ")
            open_tag = ("<img src='")
            close_tag = ("'>")
        elif (user_input == "q"):
            wrt_on_exit(filename)
        else:
            choice = (2)

            while True:
                title = get_input("Insert the link title you want to display on the website: ", clear)
                if (title != ""):
                    message = ("Insert the link you want to embed: ")
                    open_tag = ("<a href='")
                    close_tag = ("</a>")
                    break
                else:
                    print("Entry cannot be blank")

        text = get_input(message, clear)
        counter = wrt_tg_to_f(text, counter, open_tag, close_tag, filename, title, choice)

def get_input(message, clear):
    user_input = input(message)
    os.system(clear)
    return user_input

def wrt_tg_to_f(text, counter, open_tag, close_tag, filename, title, choice):
    if (choice == 1):
        f = open(filename, "a")
        f.write(open_tag + text + close_tag + "\n")
        f.close()
        counter = counter + 1
    else:
        f = open(filename, "a")
        f.write(open_tag + text + "'>" + title + close_tag + "\n")
        f.close()
        counter = counter + 1
    return counter

def wrt_on_exit(filename):
    f = open(filename, "a")
    f.write("\n</body>")
    f.write("\n</html>")
    f.close()
    quit()

main()
