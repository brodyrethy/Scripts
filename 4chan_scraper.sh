# Get URL as $1,$2,$3,$4...
# Case statement to check if arg(s) given

URL="https://boards.4channel.org/w/thread/2180153"
THREAD_NUM=$(sed -e 's/https:\/\/boards.4channel.org\/*\/thread\//g' -e 's/\///g')

# Check if any args given
if [ $# -eq 0 ]
then
	echo ":: No URL(s) given"; exit 1
fi

URLS=( "$@" )

for URL in ${URLS[@]}
do
	curl "$URL" --output "$THREAD_NUM" > /dev/null 2>1& && echo "" || echo ":: "

	MEDIA_URLS=( $(grep -e "*.webm" -e "*.jpg" -e "*.png" -e "*.gif" "$THREAD_NUM") )
	for MEDIA_URL in $MEDIA_URLS
	do
		FILENAME=$(sed -e 's/https:\/\/i.4cdn.org\/w\///g' -e 's/\///g')
		curl "$MEDIA_URL" --output "$FILENAME"
	done
done

exit 0
