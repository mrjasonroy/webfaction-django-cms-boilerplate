#!/bin/sh
echo "Username of your Webfaction account:"
read username

echo "Name of your git repository (without the .git):"
read gitname

echo "DB name and DB user (should be the same):"
read dbname

echo "DB password:"
read dbpassword

cd $HOME/src
export GIT_SSL_NO_VERIFY=true
git clone https://$username@git.$username.webfactional.com/$gitname.git website_src
cd $HOME
./bin/deploy-website.sh -no-syncdb
cd $HOME/webapps/static
ln -s $HOME/lib/python2.6/cms/media/cms
ln -s $HOME/lib/python2.6/multilingual/media/multilingual
ln -s $HOME/lib/python2.6/filer/media/filer
ln -s $HOME/webapps/django/lib/python2.6/django/contrib/admin/media

echo "Deleting standard django project"
rm -rf $HOME/webapps/django/myproject

echo "Modifying myproject.wsgi"
sed -i 's/myproject/project/g' $HOME/webapps/django/myproject.wsgi
sed -i "/^import sys/r $HOME/src/webfaction-django-cms-boilerplate/lib/wsgi_addon.txt" $HOME/webapps/django/myproject.wsgi

echo "Creating local_settings.py"
cd $HOME/webapps/django/project
cp local_settings.py.sample local_settings.py
sed -i "s/dbname/$dbname/g" local_settings.py
sed -i "s/dbpassword/$dbpassword/g" local_settings.py
sed -i "s!projectroot!/home/$username/webapps/!g"

echo "Initiating database"
cd $HOME/webapps/django/project
python2.6 manage.py syncdb --all
python2.6 manage.py migrate --fake
restart-apache.sh

echo "BINGO! We are ready to start developing!"
