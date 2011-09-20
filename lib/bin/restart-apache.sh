#!/bin/sh
django_folder=bison_django
static_folder=bison_static
media_folder=bison_media

cd ~/webapps/$django_folder/apache2/bin
./restart
