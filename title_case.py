#!/usr/bin/python3
import readline

def main():
    words = input("Insert title: ")
    words = words.split(" ")

    # separator
    print("")

    for x in words:
        word = x.lower()
        if ((word == "a") or (word == "an") or (word == "the") or (word == "in") or (word == "on") or (word == "by") or (word == "with") or (word == "of") or (word == "and") or (word == "but") or(word == "or")):
            print(word.lower(), end=" ")
        else:
            print(word.capitalize(), end=" ")

    input("\n\nPress Enter to close")

main()
