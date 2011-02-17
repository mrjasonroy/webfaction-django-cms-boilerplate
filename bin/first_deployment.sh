#!/bin/sh
echo "Username of your Webfaction account:"
read username

echo "Name of your git repository (without the .git):"
read gitname

cd $HOME/src
export GIT_SSL_NO_VERIFY=true
git clone https://$username@git.$username.webfactional.com/$gitname.git website_src
cd $HOME
./bin/deploy-website.sh
cd $HOME/webapps/static
ln -s $HOME/lib/python2.6/cms/media/cms
ln -s $HOME/lib/python2.6/multilingual/media/multilingual
ln -s $HOME/lib/python2.6/filer/media/filer
ln -s $HOME/webapps/django/lib/python2.6/django/contrib/admin/media

echo "Deleting standard django project"
rm -rf $HOME/webapps/django/myproject

echo "Modifying myproject.wsgi"
sed -i 's/myproject/project/g' $HOME/webapps/django/myproject.wsgi
sed -i '/^import sys/r $HOME/src/webfaction-django-cms.boilerplate/lib/wsgi_addon.txt' $HOME/webapps/django/myproject.wsgi

echo "Nearly done! Now create your local_settings.py and adjust your myproject.wsgi, then run restart-apache.sh"
