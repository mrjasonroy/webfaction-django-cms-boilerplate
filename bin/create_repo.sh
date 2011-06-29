#!/usr/bin/env bash
echo "Name of your git repository (without the .git):"
read reponame

echo "Creating bare git repository"
cd $HOME/webapps/git/
git init --bare ./repos/$reponame.git
cd repos/$reponame.git
git config http.receivepack true
cd $HOME

echo "Installing SCONs"
cd $HOME/src
wget http://downloads.sourceforge.net/project/scons/scons/2.0.0.final.0/scons-2.0.0.final.0.tar.gz
tar -zxvf scons-2.0.0.final.0.tar.gz
cd scons-2.0.0.final.0
python2.7 setup.py install

echo "Installing CSSTidy"
cd $HOME/src
wget http://downloads.sourceforge.net/project/csstidy/CSSTidy%20%28C%2B%2B%2C%20stable%29/1.3/csstidy-source-1.4.zip
unzip csstidy-source-1.4.zip -d csstidy
cd csstidy
scons
cd $HOME/bin
ln -s $HOME/src/csstidy/release/csstidy/csstidy .

echo "Installing SASS"
cd $HOME
mkdir gems
echo "export GEM_HOME=$PWD/gems" >> $HOME/.bashrc
export GEM_HOME=$HOME/gems
gem install haml

echo "Installing Xapian" 
cd ~/src
wget http://oligarchy.co.uk/xapian/1.2.6/xapian-core-1.2.6.tar.gz
tar zxf xapian-core-1.2.6.tar.gz
cd xapian-core-1.2.6
./configure --prefix=$HOME
make
make install
cd ..
wget http://oligarchy.co.uk/xapian/1.2.6/xapian-bindings-1.2.6.tar.gz
tar zxf xapian-bindings-1.2.6.tar.gz
cd xapian-bindings-1.2.6
./configure --prefix=$HOME \
PYTHON=/usr/local/bin/python2.7 \
PYTHON_LIB=$HOME/lib/python2.7 \
--with-python --without-ruby \
--without-php --without-tcl
make
make install

echo "Copying deployment scripts"
cp $HOME/src/webfaction-django-cms-boilerplate/lib/bin/* $HOME/bin/

echo "Creating .ssh folder"
cd $HOME
mkdir .ssh
chmod 700 .ssh
chmod 750 $HOME
cd .ssh
touch authorized_keys
chmod 644 authorized_keys
