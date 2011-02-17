ATTENTION! DO NOT USE THIS, YET!
This has not been tested against a clean Webfaction account, yet.

What is it all about?
=====================

If you start new Django projects on a regular basis for new customers and if you host your projects at `Webfaction <http://www.webfaction.com>`_, this repo is for you. This project relies on our `django-cms-html5-1140px-boilerplate <https://github.com/bitmazk/django-cms-html5-1140px-boilerplate>`_, so you should get familiar with that one first. This script only works if you name your Django application "django" and if you name your static application "static".

Below you will find step by step instructions for your control panel settings, for setting up your local development environment and your Webfaction server environment.

In the end you will have your django-cms powered website in a private git repository on your Webfaction server. You will be able to develop in a virtual environment on your local machine and push your changes to the git repository. When you have implemented and tested everything, you will be able to deploy your changes by simply ssh-ing into your Webfaction account and run a script called "deploy-website.sh". The script will checkout your latest changes, use rsync to copy all changed files to their destinations within your webapps folder and finally restart your apache process.

Sounds good? Ok! Let's do it...

Webfaction Control Panel Settings
=================================

* Login to your Webfaction account at https://panel.webfaction.com
* Go to "Domains / websites --> Domains"
* Edit the existing yourname.webfactional.com Domain and add "git" as a subdomain
* Add your desired domain "yourdomain.com" and add "www" as a subdomain
* Go to "Domains / websites --> Applications"
* Add an application with name "django" and type "Django". The standard type should be fine (latest stable release with mod_wsgi / Python 2.6)
* Add an application with name "static" and type "Static/CGI/PHP"
* Add an application with name "git" and type "Git" and extra info "yourgitpassword"
* Go to "Domains / websites --> Websites"
* Edit the existing yourname.webfactional.com website and mount "django" to "/" and "static" to "/static". If you have a real domain name already, also select it in the "Subdomains" selection box.
* Add a new site with name "git", HTTPS enabled, subdomain "git.yourname.webfactional.com" and mount "git" to "/"
* Go to "Databases"
* Add a new database. The standard name should be fine. Note down your password as you will need it later or create a new password if desired.

Now wait ten minutes, then visit `https://git.yourname.webfactional.com <https://git.yourname.webfactional.com>`_. You should be able to login with your webfaction username and the password that you chose in the extra info field when setting up the git application earlier.

You should also see the standard Django page when visiting your real domain. Time to create a real project and establish an easy publishing workflow...

Setup Local django-cms Project
==============================    

* Create a project folder somewhere on your local development machine
* cd into that project folder
* Follow the instructions at `django-cms-html5-1140px-boilerplate <https://github.com/bitmazk/django-cms-html5-1140px-boilerplate>`_ to get a fully functional django / django-cms setup in a newly initiated git repository

At the next step we will place this new local git repository on your Webfaction server, install all neccessary Python modules and deploy your local project on the server. If all goes well, you only need to edit your local_settings.py manually and restart the Apache process.

Install Everything on your Webfaction Server
============================================

Webfaction account::

  mkdir src
  cd src
  git clone git://github.com/bitmazk/webfaction-django-cms-boilerplate.git
  cd webfaction-django-cms-boilerplate
  ./bin/create_repo.sh

Local account::

  cd path/to/your/project/
  git config http.sslVerify false
  git remote add origin https://[yourname]@git.[yourname].webfactional.com/[reponame].git
  git push origin master

Webfaction account::

  cd $HOME/src/webfaction-django-cms-boilerplate
  ./bin/first_deployment.sh
