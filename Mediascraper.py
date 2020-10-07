import re, requests
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
        print("Either the URL doesn't exist, or you aren't connected to the Internet. Try again later")

def main():
    while (True):
        user_input = input("Insert the URL of the webpage you want to download media from (Press Return to quit): ")
        if (user_input == ""):
            print("Quitting...")
            quit()

        links = get_links(user_input)
        #Add an entry for each file extension you want to scrape a webpage for
        #Each link discovered using the algorithm will be downloaded
        #download_content("txt", links)
        #download_content("mp3", links)
        #download_content("mp4", links)
        #download_content("mkv", links)
        download_content("png", links)
        download_content("gif", links)
        download_content("jpg", links)
        download_content("jpeg", links)

main()
