#!/bin/sh

. ../../settings

# if the first Argument is not set to 1, syncdb and migrate will be executed
cd ~/src/website_src
git pull
rsync -avz --stats --delete --exclude-from=$HOME/bin/rsync-excludes-django.txt ~/src/website_src/webapps/$django_folder/project ~/webapps/$django_folder/
rsync -avz --stats --delete ~/src/website_src/webapps/$static_folder/ ~/webapps/$static_folder/
cd ~/webapps/$django_folder/project
if [ $1 ]; then
	:
else
	python2.7 manage.py syncdb
	python2.7 manage.py migrate
        cd ~/webapps/$django_folder/apache2/bin
	./restart
fi
exit 0

