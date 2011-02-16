#!/bin/sh
cd ~/src/website_src
git pull
rsync -avz --stats --delete --exclude-from=$HOME/bin/rsync-excludes-django.txt ~/src/website_src/webapps/django/project ~/webapps/django/
rsync -avz --stats --delete --exclude-from=$HOME/bin/rsync-excludes-static.txt ~/src/website_src/webapps/static/ ~/webapps/static/
cd ~/webapps/django/project
python2.6 manage.py syncdb
python2.6 manage.py migrate
cd ~/webapps/django/apache2/bin
./restart
exit 0

