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
