What is it all about?
=====================

If you start new Django projects on a regular basis for new customers and if
you host your projects at `Webfaction <http://www.webfaction.com>`_, this repo
is for you. This project relies on our `django-cms-html5-1140px-boilerplate
<https://github.com/bitmazk/django-cms-html5-1140px-boilerplate>`_, so you
should get familiar with that one first. This script only works if you name
your Django application "django" and if you name your static application
"static".

Below you will find step by step instructions for your control panel settings,
for setting up your local development environment and your Webfaction server
environment.

In the end you will have your django-cms powered website in a private git
repository on your Webfaction server. You will be able to develop in a virtual
environment on your local machine and push your changes to the git repository.
When you have implemented and tested everything, you will be able to deploy
your changes by simply ssh-ing into your Webfaction account and run a script
called "deploy-website.sh". The script will checkout your latest changes, use
rsync to copy all changed files to their destinations within your webapps
folder and finally restart your apache process.

Sounds good? Ok! Let's do it...

Webfaction control panel settings
=================================

* Login to your Webfaction account at https://panel.webfaction.com
* Go to "Domains / websites --> Domains"
* Edit the existing yourname.webfactional.com Domain and add "git" as a
  subdomain
* Add your desired domain "yourdomain.com" and add "www" as a subdomain
* Go to "Domains / websites --> Applications"
* Add an application with name "django" and type "Django". The standard type
  should be fine (latest stable release with mod_wsgi / Python 2.6)
* Add an application with name "static", type "Static only" and setting
  "expires max"
* Add an application with name "media", type "Static only" and setting
  "expires max"
* Add an application with name "git" and type "Git" and extra info
  "yourgitpassword"
* Go to "Domains / websites --> Websites"
* Edit the existing yourname.webfactional.com website and mount "django" to "/"
  and "static" to "/static". If you have a real domain name already, also select
  it in the "Subdomains" selection box.
* Add a new site with name "git", HTTPS enabled, subdomain
  "git.yourname.webfactional.com" and mount "git" to "/"
* Go to "Databases"
* Add a new database. The standard name should be fine. Note down your password
  as you will need it later or create a new password if desired.

Now wait a few minutes, then visit `https://git.yourname.webfactional.com
<https://git.yourname.webfactional.com>`_. You should be able to login with
your webfaction username and the password that you chose earlier as extra info
when setting up the git application.

You should also see the standard Django page when visiting your real domain.
Time to create a real project and establish an easy publishing workflow...

Setup local django-cms project
==============================

Throughout this script you will get some prompts like "Password: ". These
happen when a "git pull" command is called. Therefore the password you need to
enter is the one that you chose for your git application.

* Create a project folder somewhere on your local development machine
* cd into that project folder
* Follow the instructions at `django-cms-html5-1140px-boilerplate
  <https://github.com/bitmazk/django-cms-html5-1140px-boilerplate>`_
  to get a fully functional django / django-cms setup in a newly initiated git
  repository

At the next step you will place this new local git repository on your Webfaction
server, install all neccessary Python modules and deploy your local project on
the server. If all goes well, you will have a fresh new django-cms site up and
running.

Install everything on your webfaction server
============================================

Webfaction account::

  mkdir src
  cd src
  git clone git://github.com/bitmazk/webfaction-django-cms-boilerplate.git
  cd webfaction-django-cms-boilerplate
  ./bin/create_repo.sh

It might happen that your ssh session freezes for example at
"Downloading/unpacking south". In case of this event you can just open another
terminal and start a new ssh session. Monitor your "$HOME/bin" folder. When a
symlink called "csstidy" and a file called "sass" appears inside that folder,
the script has continued successfully and you can terminate the frozen
session.

If anyone knows why this happens I would be more than happy for a hint on how
to prevent the constant freezing of ssh sessions to Webfaction servers!

A nice workaround for this is using screen. Just type ``screen -S foobar``
before you do anything on the server. Now whenever your session freezes you can
just ssh into the server again and do ``screen -d -R foobar``. You will be back
in your once frozen session and can see what is going on.

Local account::

  cd path/to/your/project/
  git config http.sslVerify false
  git config http.postBuffer 524288000
  git remote add origin https://[yourname]@git.[yourname].webfactional.com/[reponame].git
  git push -u origin master

Webfaction account::

  cd $HOME/src/webfaction-django-cms-boilerplate
  ./bin/first_deployment.sh

License
=======

`The Unlicense <http://unlicense.org>`_
