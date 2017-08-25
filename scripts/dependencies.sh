#!/bin/bash

youtubedlBoolean=false

echo
echo "///////////////////////////////////////////////////////////"
echo "/////////////// corroborando dependencias /////////////////"
	{
  YOUTUBEDL_SEARCH_DEPENDENCY=$(dpkg -s youtube-dl 2>&1)
  } &> /dev/null

#si no existe la dependencia Youtube-dl la instala
if [[ $YOUTUBEDL_SEARCH_DEPENDENCY == *"dpkg-query:"* ]]; then
	echo instalando la dependencia Youtube-dl, aguarde por favor...
  YOUTUBEDL_INSTALL=$(sudo apt-get install sox)

  {
  YOUTUBEDL_SEARCH_DEPENDENCY=$(dpkg -s youtube-dl 2>&1)
  } &> /dev/null

  if ! [[ $YOUTUBEDL_SEARCH_DEPENDENCY == *"dpkg-query:"* ]]; then
    $youtubedlBoolean=true
      echo dependencia Youtube-dl instalada correctamente
  fi

else 
echo "////////// Se encontro una version de Youtube-dl //////////"
fi

if [ $youtubedlBoolean = false ]; then
echo "// Todas las dependencias estan instaladas correctamente //"
echo "///////////////////////////////////////////////////////////"
echo
else
echo "/////////// hay un problema con la dependencia ////////////"
echo "///////////////////////////////////////////////////////////"

fi







