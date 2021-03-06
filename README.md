TANGAZA
=======
Thanks for choosing Tangaza. A mobile phone-based group messaging system

System Requirements
-------------------

Tangaza runs on Linux. It has been tested only on Debian based distros.
These requirements show the minimum versions of software that the system
has been tested with and that are required to successfully run.

1. Perl 5
2. Python 2.6
3. MySQL 5.0
4. Django 1.2
5. Kannel 1.4.3
6. Asterisk 1.6.2
7. Common Library (http://github.com/tangaza/Common)

Installation:
---------------

Build the application using git-buildpackage in debian
and then install the debian package (or convert to rpm). This usually means

sudo apt-get install git-buildpackage devscripts build-essential fakeroot debhelper gnupg pbuilder ubuntu-dev-tools diff patch cdbs quilt lintian alien

git clone https://github.com/tangaza/Tangaza

cd Tangaza

Tangaza references the Common Lib (http://github.com/tangaza/Common) as a submodule. Therefore you need to run the following to make sure this is also included into Tangaza:

1. git submodule init
2. git submodule update

git checkout -b upstream --track origin/master

(The '--track' option alters your .git/config file and adds a [branch "upstream"] section telling Git where you fetched it from. That means you can later just say "git pull" and you will get both the 'master' and the 'upstream' repository merged into your repository automatically.)

git checkout master

git-buildpackage --git-ignore-new --git-builder=debuild -i\.git -I.git -us -uc 

which pops out a .deb into the parent directory. Add that parent directory to your apt source.list by moving into the directory and running

$ sudo dpkg-scanpackages . /dev/null | gzip -c9 > Packages.gz

and then add this line to /etc/apt/sources.list

deb file:///the/directory/with/the/deb /

Resynchronize the package index files from their sources

$ sudo apt-get update

and install 

$ sudo apt-get install tangaza

then go to

http://localhost

and you should see the Tangaza site. Log in with the Django user name and password you set up during the package install
