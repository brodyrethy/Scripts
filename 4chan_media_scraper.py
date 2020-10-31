import re, requests, time
from requests_html import HTMLSession

def get_links(user_input):
    session = HTMLSession()
    x = session.get(user_input)
    links = x.html.links
    return links

def download_content(file_extension, links):
    counter = 0
    try:
        x = re.compile(".*" + file_extension)
        linkSearch = list(filter(x.match, links))
        for link in linkSearch:
            counter = counter + 1
            req = requests.get('http:' + link)
            with open(str(counter) + "." + file_extension, 'wb') as f:
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

    while (True):
        user_input = input("Insert the URL of the 4chan thread you'd like to download from (Press Return to quit): ")
        if (user_input == ""):
            print("Ensure that you have removed or renamed your downloaded images to avoid accidental overwrites")
            time.sleep(5)
            quit()

        links = get_links(user_input)

        for x in file_extensions:
            download_content(x, links)

        print("Done")

main()
