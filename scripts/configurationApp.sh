
startCheck(){
	userChangerConfiguration=$1
	while read -r line
	do
	if [[ $line == *"STATE_CONFIGURATION"* ]]; then
		BOOLEAN=$(echo $line | cut -d "=" -f 2)
    fi
  
	done < config/Configuration

	if [[ $BOOLEAN == false ]] || [[ $userChangerConfiguration == false ]]; then
		tipeConfigurationMenu
	fi
	#ELIMINO LA ULTIMA LISTA GENERADA DE MIX
	cd scripts
	if [[ -f listVideos ]]; then
	rm listVideos
	fi
	cd ..

	echo " " >> listDownload.txt
}


manualConfiguration(){
	echo 
	echo "Ingrese la carpeta donde se guardara la musica"
	echo "Ejemplo /home/miUsuario/Musica"
	read dirmp3Paramiter

	echo 
	echo "Ingrese la carpeta donde se guardara los video"
	echo "Ejemplo /home/miUsuario/Video"	
	read dirVideoParamiter

	echo 
	echo "La carpeta seleccionada para musica fue: "$dirmp3Paramiter 
	echo "La carpeta seleccionada para videos fue: "$dirVideoParamiter

	echo 
	echo "esta seguro de estos parametros? escriba y/yes/si si esta de acuerdo"
	read acceptedOrDeclined

	if [[ $acceptedOrDeclined == "y" ]] || [[ $acceptedOrDeclined == "yes" ]] || [[ $acceptedOrDeclined == "si" ]];then

		touch $PWD/config/Configuration2
		dir1='DIR_MP3='$dirmp3Paramiter
		dir2='DIR_VIDEO='$dirVideoParamiter
		echo 'STATE_CONFIGURATION=true' >> config/Configuration2
		echo $dir1 >> config/Configuration2
		echo $dir2 >> config/Configuration2
		rm config/Configuration
		mv config/Configuration2 config/Configuration
		echo 
		echo "Encontrara sus musica en: "$dir1
		echo "Encontrara sus videos en: "$dir2
		echo

		instalarDependenciasNodeJS
	else
		startCheck
	fi

}

autoConfiguration() {
	touch $PWD/config/Configuration2
	dir1='DIR_MP3='Music
	dir2='DIR_VIDEO='Video
	echo 'STATE_CONFIGURATION=true' >> config/Configuration2
	echo $dir1 >> config/Configuration2
	echo $dir2 >> config/Configuration2
	rm config/Configuration
	mv config/Configuration2 config/Configuration
	echo 
	echo "Encontrara sus musica en: "$PWD"/Music"
	echo "Encontrara sus videos en: "$PWD"/video"
	echo

	instalarDependenciasNodeJS
}


tipeConfigurationMenu(){
	if [[ $userChangerConfiguration == false ]]; then
		echo
		echo CONFIGURACION APP
		echo "como desea configurar la app?"
		echo "1 ) manual"
		echo "2 ) automatico"
		echo "seleccione un numero o cualquier otra tecla para salir del menu"
		read optionConfiguration
		echo 
		if [[ $optionConfiguration == "1" ]];then
			manualConfiguration
		else
			if [[ $optionConfiguration == "2" ]]; then
				autoConfiguration
			else
				source ./run.sh
			fi	
		fi
	else
		echo
		echo CONFIGURACION APP
		echo "como desea configurar la app?"
		echo "1 ) manual"
		echo "2 ) automatico"
		echo "seleccione un numero"
		read optionConfiguration
		echo 
		if [[ $optionConfiguration == "1" ]];then
			manualConfiguration
		else
			if [[ $optionConfiguration == "2" ]]; then
				autoConfiguration
			else
				echo 
				echo "el comando ingresado es invalido"
				echo 
				tipeConfigurationMenu
			fi	
		fi
	fi

}

instalarDependenciasNodeJS(){
cd nodejs
echo "abriendo una nueva consola"
gnome-terminal -e "npm install"
cd ..
cd scripts
}

startCheck $1