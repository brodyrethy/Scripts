import time, re
from recipe_scrapers import scrape_me
#
#	By: Brody Rethy
#	Website: https://rethy.xyz 
#            https://ezrecipe.xyz
#
#	Name: Recipe page generator
#	Version: 1.0
#
#	Summary:
#   A script used to create HTML files from the scraped contents of
#   big sites like https://allrecipes.com, , and most of the big ones.
#   
#   I use this for my website, https://ezrecipe.xyz, a home to 5k of the most minimal recipe
#   content possible, free from ads, trackers, and pointless life stories.
#

def main():
    url_num = 218906
    num_file = "ezrecipe_scraper_num.log"

    try:
        f = open(num_file, "r")
        url_num = f.read()
        f.close()
    except FileNotFoundError:
        # init the file for next time
        f = open(num_file, "w")
        f.write("")
        f.close()

    while True:
        # give the url as a string, it can be url from any site listed below
        scraper = scrape_me("https://www.allrecipes.com/recipe/"+str(url_num)+"/")
        #scraper = scrape_me('https://www.feastingathome.com/tomato-risotto/', wild_mode=True)

        title = scraper.title()
        total_time = scraper.total_time()
        yields = scraper.yields()
        ingredients = scraper.ingredients()
        instructions = scraper.instructions()
        images = scraper.image()
        #host = scraper.host()
        #scraper.links()
        nutrients = scraper.nutrients()

        print(title)
        #print(total_time)
        #print(ingredients)
        print(images)
        #print(instructions)
        #print(nutrients)
        #print(yields)
        #instructions = instructions.split(".")
        instructions = split_into_sentences(instructions)

        if (not title):
            print("Passing on", title)
        elif (images = "<img src='https://www.allrecipes.com/img/misc/og-default.png'>")
            print("Pressing on", title)
        else:
            file_title = title.replace(" ", "_").replace("'", "_").replace(",", "_").lower()

            f = open(file_title + ".html", "w")
            f.write("<html>\n")
            f.write("<head>\n")
            f.write("<meta charset='UTF-8' />\n")
            f.write("<meta name='viewport' content='width=device-width' />\n\n")
            f.write("<link rel='stylesheet' type='text/css' href='../style.css' />\n")
            f.write("<link rel='icon' href='../files/icon.jpg' />\n")
            f.write("<title>" + title + "</title>\n")
            f.write("</head>\n\n")
            f.write("<body>\n")
            f.write("<h1>" + str(title) + "</h1>\n\n")
            f.write("<p>\n")
            f.write("<img src='" + images + "'>\n")
            f.write("</p>\n\n")
            f.write("<h2>Cook Time</h2>\n")
            f.write("<ul>\n")
            f.write("<li>Cook time: " + str(total_time) + " minutes</li>\n")
            f.write("</ul>\n\n")
            f.write("<h2>Ingredients</h2>\n")
            f.write("<ul>\n")
            for ingredient in ingredients:
                f.write("<li>" + ingredient + "</li>\n")
            f.write("</ul>\n\n")
            f.write("<h2>Yield</h2>\n")
            f.write("<ul>\n")
            f.write("<li>" + yields + "</li>\n\n")
            f.write("</ul>\n\n")
            f.write("<h2>Instructions</h2>\n")
            #f.write("<ul>\n")
            f.write("<ul>\n")
            for instruction in instructions:
                f.write("<li>" + instruction + "</li>\n")
            f.write("</ul>\n\n")
            #f.write("</ul>\n")
            if (nutrients):
                f.write("\n\n<h2>Nutrients</h2>\n")
                f.write("<ul>\n")
                for nutrient in nutrients:
                    f.write("<li>" + nutrient + "</li>\n")
                f.write("</ul>\n")
            f.write("</body>\n")
            f.write("</html>")
            f.close()
            pass
        url_num = url_num + 1



# Thank you, D Greenberg
def split_into_sentences(text):
    alphabets = "([A-Za-z])"
    prefixes = "(Mr|St|Mrs|Ms|Dr)[.]"
    suffixes = "(Inc|Ltd|Jr|Sr|Co)"
    starters = "(Mr|Mrs|Ms|Dr|He\s|She\s|It\s|They\s|Their\s|Our\s|We\s|But\s|However\s|That\s|This\s|Wherever)"
    acronyms = "([A-Z][.][A-Z][.](?:[A-Z][.])?)"
    websites = "[.](com|net|org|io|gov)"

    text = " " + text + "  "
    text = text.replace("\n"," ")
    text = re.sub(prefixes,"\\1<prd>",text)
    text = re.sub(websites,"<prd>\\1",text)
    if "Ph.D" in text: text = text.replace("Ph.D.","Ph<prd>D<prd>")
    text = re.sub("\s" + alphabets + "[.] "," \\1<prd> ",text)
    text = re.sub(acronyms+" "+starters,"\\1<stop> \\2",text)
    text = re.sub(alphabets + "[.]" + alphabets + "[.]" + alphabets + "[.]","\\1<prd>\\2<prd>\\3<prd>",text)
    text = re.sub(alphabets + "[.]" + alphabets + "[.]","\\1<prd>\\2<prd>",text)
    text = re.sub(" "+suffixes+"[.] "+starters," \\1<stop> \\2",text)
    text = re.sub(" "+suffixes+"[.]"," \\1<prd>",text)
    text = re.sub(" " + alphabets + "[.]"," \\1<prd>",text)
    if "”" in text: text = text.replace(".”","”.")
    if "\"" in text: text = text.replace(".\"","\".")
    if "!" in text: text = text.replace("!\"","\"!")
    if "?" in text: text = text.replace("?\"","\"?")
    text = text.replace(".",".<stop>")
    text = text.replace("?","?<stop>")
    text = text.replace("!","!<stop>")
    text = text.replace("<prd>",".")
    sentences = text.split("<stop>")
    sentences = sentences[:-1]
    sentences = [s.strip() for s in sentences]
    return sentences

main()
