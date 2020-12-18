import re, requests, time, os
from requests_html import HTMLSession

def write_photo_number(photo_counter):
    f = open("photo_counter.txt", "w")
    f.write(str(photo_counter))
    f.close()

def get_links(user_input):
    session = HTMLSession()
    x = session.get(user_input)
    links = x.html.links
    return links

def download_content(file_extension, links):
    try:
        x = re.compile(".*" + file_extension)
        linkSearch = list(filter(x.match, links))
        for link in linkSearch:
            photo_counter = photo_counter + 1
            req = requests.get('http:' + link)
            with open(str(photo_counter) + "." + file_extension, 'wb') as f:
                f.write(req.content)
    except:
        print("Either the URL doesn't exist, or you aren't connected to the Internet")

def main():
    #Add an entry for each file extension you want to scrape a webpage for
    #Each link discovered using the algorithm will be downloaded
        #"txt"
        #"mkv"
        #"webm"
    file_extensions = ["png", "gif", "jpg", "jpeg"]

    if (os.path.isfile("photo_counter.txt") == False):
        photo_counter = 0
    else:
        fo = open("photo_counter.txt", "r")
        photo_counter = fo.read()

    while (True):
        user_input = input("Insert the URL of the 4chan thread you'd like to download from (Press Return to quit): ")
        if (not user_input):
            write_photo_number(photo_counter)
            print("Ensure that you have removed or renamed your downloaded images to avoid accidental overwrites")
            quit()

        links = get_links(user_input)

        for x in file_extensions:
            download_content(x, links)

        print("Done")

main()
