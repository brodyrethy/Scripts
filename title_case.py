#!/usr/bin/python3

while (True):
    counter = 0

    words = input("Insert title (press Return to quit): ")

    if (not words):
        quit()

    words = words.split(" ")

    for x in words:
        counter += 1

        word = x.lower()

        if (counter <= 1):
            print(word.capitalize(), end=" ")
        elif ((word == "a") or (word == "an") or (word == "the") or (word == "in") or (word == "on") or (word == "by") or (word == "with") or (word == "of") or (word == "and") or (word == "but") or(word == "or")):
            print(word.lower(), end=" ")
        else:
            print(word.capitalize(), end=" ")

    print("\n")
