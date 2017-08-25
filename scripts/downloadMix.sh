
url=$1
cd nodejs
gnome-terminal -e "node index.js"
cd ..
cd scripts

content=$(wget -O "htmlYoutube.html" $url -q )
touch request
touch response

	if [ -f listDownload ]; then
		rm listDownload
		touch listVideos
	fi

echo "iniciando servicios en NODE JS"
sleep 2

while read -r line
	do
	if [[ $line == *'<a href="/watch?v='* ]]; then

		echo $line >> request
    fi
  
	done < htmlYoutube.html

rm htmlYoutube.html

result=$(curl --request POST --url 'http://localhost:5000/api/generate/url/youtube')

echo "aguarde por favor.. 3"
sleep 1
echo "aguarde por favor.. 2"
sleep 1
echo "aguarde por favor.. 1"
sleep 1

echo "ESTADO generador de links NODE JS: " $result

flag="0"
arrayVideos=();
	while read -r line
	do
		arrayVideos+=("$line")
	done < response


string=$(echo "${arrayVideos[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')

IFS=' ' read -r -a array <<< "$string"

COUNT=0;
for videos in ${array[@]}
do
	if [[ $COUNT < $CANT_VIDEO_DOWNLOAD ]]; then
	echo "https://youtube.com/watch?v="$videos >> listVideos
    COUNT=$(( $COUNT + 1))
    fi
done

rm request
rm response

echo "listado de videos generados con exito"