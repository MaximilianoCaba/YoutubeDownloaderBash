cd "${0%/*}"

pathProyect="$PWD"

source ./scripts/configurationApp.sh

#Corrobora que las dependencias necesarias para la ejecucion se encuentren instaladas
source ./scripts/dependencies.sh

#obtengo los parametros de configuracion de la aplicacion
{
  CONFIGURATION=$(cat ./config/Configuration 2>&1)
} &> /dev/null

while read -r line
do
	if [[ $line == *"DIR_MP3"* ]]; then
		DIR_MP3=$(echo $line | cut -d "=" -f 2)
    fi

    if [[ $line == *"DIR_VIDEO"* ]]; then
		DIR_VIDEO=$(echo $line | cut -d "=" -f 2) 
    fi
        
done < config/Configuration

#se asegura que existan las carpetas, de lo contrario las crea
source ./scripts/folders.sh $DIR_VIDEO $DIR_MP3

homeFunction(){

echo "Que desea? escriba el numero de la opcion"

echo "1 ) Descargar en formato mp4 (video)"
echo "2 ) Descargar en formato mp3 (musica)"
echo "3 ) Configuracion de APP"

echo "" >> listDownload.txt

read inputOption

case $inputOption in
	1)
		typeDownload="video";
		downloadAndConvertFunction $typeDownload
	;;
	2)
		typeDownload="mp3";
		downloadAndConvertFunction $typeDownload
	;;

	3)
		source ./scripts/configurationApp.sh false
	;;

	*)
		echo "Comando invalido, elija entre las opciones seleccionadas"
		homeFunction
	;;
esac



}

downloadAndConvertFunction(){
	typeDownload=$1

while read -r line
do
	if [[ $line == *"list"* ]] && [[ $line == *"watch"* ]]; then
		
		source ./scripts/downloadMix.sh $line
		echo "cargando lista de videos generados..."
		cd ..
		sleep 2

		COUNT_VIDEOS=0;
		while read -r line
		do
       	 	COUNT_VIDEOS=$(( $COUNT_VIDEOS + 1))
		done < scripts/listVideos;

		cantVideosDownload $COUNT_VIDEOS

		local CANT_VIDEO_DOWNLOAD=$?

		COUNT=0;
		while read -r line
		do
			echo "VIDEO DESCARGADOS "$COUNT " DE " $CANT_VIDEO_DOWNLOAD
			echo "DESCARGANDO...."
       	 	proccessVideo $typeDownload $line
       	 	COUNT=$(( $COUNT + 1))
		done < scripts/listVideos
	
	else

	URL=$(echo $line | cut -d "&" -f 1)
	proccessVideo $typeDownload $URL

	fi
        
done < listDownload.txt
	
	cd $pathProyect
	rm listDownload.txt
	touch listDownload.txt

echo 
echo "---> TODOS LOS VIDEOS AN SIDO DESCARGADOS Y CONVERTIDOS EXITOSAMENTE! <---"
echo

}

echo 
echo "////////////////////////////////////////////"
echo "/////// DESCARGAR VIDEOS DE YOUTUBE ////////"
echo "////////////////////////////////////////////"
echo

proccessVideo(){

	typeDownload=$1
	URL=$2
	
	#UNA URL DE UN VIDEO DE YOUTUBE TIENE COMO MINIMO 43 PALABRAS
	if [[ ${#URL} > 35 ]] && [[ $line == *"https://www.youtube.com"* ]] ; then

	echo
	echo "------> PROCESANDO VIDEO: " $URL
	echo

	 	if [[ $typeDownload == "video" ]]; then
			cd $DIR_VIDEO
				sudo youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 $URL
			cd "${0%/*}"
			sudo find $DIR_VIDEO -type f -exec chmod 777 {} \;

		else
			cd $DIR_MP3
				sudo youtube-dl --extract-audio --audio-format mp3 $URL
			cd "${0%/*}"
			sudo find $DIR_MP3 -type f -exec chmod 777 {} \;
		fi
 	


	echo
	echo "------> VIDEO PROCESADO CON EXITO "
	echo
fi
	
}

cantVideosDownload(){
	COUNT_VIDEOS=$1;
	echo "La lista tiene "$COUNT_VIDEOS" videos para procesar"
	value=$COUNT_VIDEOS
	if [[ $COUNT_VIDEOS > 50 ]]; then
		value=50 
	fi
		echo "Se descargaran "$value" videos."
		return $value
}



homeFunction
