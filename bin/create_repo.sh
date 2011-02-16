#!/usr/bin/env bash
echo "Name of your git repository (without the .git):"
read reponame

cd $HOME/webapps/git/
./bin/git init --bare ./repos/$reponame.git
cd repos/$reponame.git
../../bin/git config http.receivepack true

