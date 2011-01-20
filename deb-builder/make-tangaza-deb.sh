#! /bin/bash

#
#    Tangaza
#
#    Copyright (C) 2010 Nokia Corporation.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#    Authors: Billy Odero
#

#set -e 

TANGAZA_SCRIPTS=$HOME/git/Tangaza
COMMON_SCRIPTS=$HOME/git/Common

if [ -d "/var/lib/tomcat6/webapps/ROOT/jobs" ]; then
    BUILD_BOT_HOME=/var/lib/tomcat6/webapps/ROOT/jobs
    TANGAZA_SCRIPTS=$BUILD_BOT_HOME/Tangaza/workspace
    COMMON_SCRIPTS=$BUILD_BOT_HOME/Common/workspace
fi

INST_LOCATION=$TANGAZA_SCRIPTS/deb-builder/tangaza-1.0/

#mkdir $INST_LOCATION

# 1. copy complete source
echo "Exporting Tangaza files"
shopt -s extglob
cp -r $TANGAZA_SCRIPTS/!(deb-builder|.git) $INST_LOCATION/
cp -r $COMMON_SCRIPTS $INST_LOCATION/agi-bin/Nokia/
rm -rf $INST_LOCATION/agi-bin/Nokia/Common/.git
find . -name *.gitignore -exec rm {} +;

# 2. create tar from source
cd $INST_LOCATION/../
tar -czf tangaza_1.0.tar.gz tangaza-1.0

# 3. set env variables
export DEBFULLNAME="Billy Odero"
export DEBEMAIL="billy.odero@fakemail.com"

# 4. generate required files with dh_make
cd $INST_LOCATION
dh_make -i -f ../tangaza_1.0.tar.gz

# 5. remove example files
echo "Starting build process"
debuild -us -uc

# 6. clean source when done
echo "Done. Clearing build files"
rm -rf  $INST_LOCATION/!(debian)
dh_clean