#!/usr/bin/python3
import sys

def main():
    words = str(sys.argv)

    words = words.split(",")

    # remove first list item (file name)
    words.pop(0)

    words.sort()

    for x in words:
        print(x)

    print("\n")

main()
