import urllib.request
# NOTE: incomplete

def main():
    start = 'https://www.youtube.com/feeds/videos.xml?channel_id='
    end = '>'

    URL = get_user_input("Insert a URL: ")

    youtube_url = get_web_content(URL)

    url, excess = youtube_url.split(start, 1)[1]

    print(url)

def get_web_content(URL):
    response = urllib.request.urlopen(URL)
    web_content = response.read().decode('utf-8').replace("\n", "")
    return web_content

def get_user_input(message):
    while (True):
        user_input = str(input(message))

        if (not user_input):
            print(":: not a valid entry")
        else:
            break
    return user_input

main()
