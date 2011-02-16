What is it all about?
=====================

If you already use our `django-cms-html5-1140px-boilerplate <https://github.com/bitmazk/django-cms-html5-1140px-boilerplate>`_ and want to push your newly created project to a `Webfaction <http://www.webfaction.com>`_ server, this repo is for you. 

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

Now wait ten minutes, then visit `https://git.yourname.webfactional.com <https://git.yourname.webfactional.com>`_. You should be able to login with your webfaction username and the password you chose in the extra info field when setting up the git application earlier.
