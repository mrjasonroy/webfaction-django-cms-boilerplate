#!/usr/bin/env bash
echo "Name of your git repository (without the .git):"
read reponame

echo "Creating bare git repository"
cd $HOME/webapps/git/
./bin/git init --bare ./repos/$reponame.git
cd repos/$reponame.git
../../bin/git config http.receivepack true
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

echo "Copying deployment scripts"
cp $HOME/src/webfaction-django-cms-boilerplate/lib/bin/* $HOME/bin/
