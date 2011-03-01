#!/bin/sh
echo "Username of your Webfaction account:"
read username

echo "Name of your git repository (without the .git):"
read gitname

echo "DB name and DB user (should be the same):"
read dbname

echo "DB password:"
read dbpassword

echo "Downloading project sources"
cd $HOME/src
export GIT_SSL_NO_VERIFY=true
git clone https://$username@git.$username.webfactional.com/$gitname.git website_src
cd website_src
git config http.sslVerify false
git config http.postBuffer 524288000

echo "Installing virtualenv"
cd $HOME
mkdir lib/python2.7
easy_install-2.7 pip
cd $HOME/src/website_src/bin
pip install -r requirements.txt

echo "Deploy website and create symlinks"
mkdir $HOME/webapps/django/project
cd $HOME
./bin/deploy-website.sh -no-syncdb
cd $HOME/webapps/static
ln -s $HOME/lib/python2.7/cms/media/cms
ln -s $HOME/lib/python2.7/filer/media/filer
ln -s $HOME/webapps/django/lib/python2.7/django/contrib/admin/media

echo "Deleting standard django project"
rm -rf $HOME/webapps/django/myproject

echo "Modifying myproject.wsgi"
sed -i 's/myproject/project/g' $HOME/webapps/django/myproject.wsgi
#sed -i "/^import sys/r $HOME/src/webfaction-django-cms-boilerplate/lib/wsgi_addon.txt" $HOME/webapps/django/myproject.wsgi

echo "Creating local_settings.py"
cd $HOME/webapps/django/project
cp local_settings.py.sample local_settings.py
sed -i "s/dbuser/$dbname/g" local_settings.py
sed -i "s/dbname/$dbname/g" local_settings.py
sed -i "s/dbpassword/$dbpassword/g" local_settings.py
sed -i "s!projectroot!/home/$username/!g" local_settings.py

echo "Initiating database"
cd $HOME/webapps/django/project
python2.7 manage.py syncdb --all
python2.7 manage.py migrate --fake
restart-apache.sh

echo "BINGO! You are ready to start developing!"
