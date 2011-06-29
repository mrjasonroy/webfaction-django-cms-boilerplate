#!/bin/sh
# if the first Argument is not set to 1, syncdb and migrate will be executed
cd ~/src/website_src
git pull
rsync -avz --stats --delete --exclude-from=$HOME/bin/rsync-excludes-django.txt ~/src/website_src/webapps/django/project ~/webapps/django/
rsync -avz --stats --delete ~/src/website_src/webapps/static/ ~/webapps/static/
cd ~/webapps/django/project
if [ $1 ]; then
	:
else
	python2.7 manage.py syncdb
	python2.7 manage.py migrate
        cd ~/webapps/django/apache2/bin
	./restart
fi
exit 0

