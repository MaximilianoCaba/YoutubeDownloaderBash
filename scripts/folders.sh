#!/bin/bash

DIR_VIDEO=$1
DIR_MP3=$2

ifExistFolderMusic(){
	if [ ! -d $DIR_MP3 ]; then
	{
  		mkdir $DIR_MP3
	} &> /dev/null
	echo "se creo una carpeta en" $DIR_MP3
	fi
}

ifExistFolderVideo(){
	if [ ! -d $DIR_VIDEO ]; then
	{
  		mkdir $DIR_VIDEO
	} &> /dev/null
	echo "se creo una carpeta en" $DIR_VIDEO
	fi
}

ifExistFolderMusic 
ifExistFolderVideo 