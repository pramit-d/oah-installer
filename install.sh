#!/bin/bash

OAH_VERSION=0.0.1-a1
OAH_NAMESPACE=${OAH_NAMESPACE:=pramit-d}
OAH_ROOT=${OAH_ROOT:="$HOME"}
OAH_DIR="$OAH_ROOT/.oah"
OAH_INSTALLER_TMP_FOLDER=$OAH_ROOT/tmp/oah-installer
OAH_SHELL_GITURL="https://github.com/${OAH_NAMESPACE}/oah-shell.git"
OAH_SHELL_REPO=oah-shell
OAH_SHELL_INSTALLER_FILE=$OAH_INSTALLER_TMP_FOLDER/$OAH_SHELL_REPO/src/bash/install.sh

# function CHECK_OAH_INSTALL
# {
# 	version=$1
# 	echo $(oah ) | grep ${version}
# }

# echo "Looking for a previous installation of OAH..."

# echo $(CHECK_OAH_INSTALL ${OAH_VERSION}) > OAH_VERSION_FOUND

# echo "OAH version check resulted in =>  $OAH_VERSION_FOUND ""!!
# #check if oah already installed
# if [$OAH_VERSION_FOUND == ${OAH_VERSION}] ; then
#  echo "Nothing to do current version found is the latest version!!"
#  exit 0
# fi

if [ -d "${OAH_DIR}" ]; then
	echo "OAH directory found."
	echo ""
	echo "======================================================================================================"
	echo " You may have OAH already installed."
	echo " The directory was found at:"
	echo ""
	echo "    ${OAH_DIR}"
	echo " Delete the dir if empty and try again  , alternatively "
	echo " Please consider running the following if you need to upgrade."
	echo ""
	echo "    $ oah selfupdate"
	echo ""
	echo "======================================================================================================"
	echo ""

	exit 0
fi

#CHECK GIT

echo "Looking for git..."
if [ -z $(which git) ]; then
	echo "Not found."
	echo "======================================================================================================"
	echo " Please install git on your system using your favourite package manager."
	echo ""
	echo " Restart after installing git."
	echo "======================================================================================================"
	echo ""
	exit 0
fi

# echo "Creating oah installer tmp folder"
# mkdir -p ${OAH_INSTALLER_TMP_FOLDER}
# cd ${OAH_INSTALLER_TMP_FOLDER}

# clone oah-shell
git clone ${OAH_SHELL_GITURL} $OAH_INSTALLER_TMP_FOLDER/$OAH_SHELL_REPO
# cd ${OAH_SHELL_REPO}
# git checkout test_install
# chmod +x ./src/bash/install.sh
chmod +x $OAH_SHELL_INSTALLER_FILE
# .${OAH_SHELL_INSTALLER_FILE}
source "$OAH_SHELL_INSTALLER_FILE"

# initialize oah shell
echo "Caching oah-shell scripts..."
source ${OAH_DIR}/bin/oah-init.sh

# TODO Check oah installation

if [[ "$?" == "0" ]]; then
	echo -e "\e[32mOah-shell installed successfully "
else
	echo -e "\e[31mSomething went wrong, installation unsuccessful!!!"
fi

[[ -d $OAH_INSTALLER_TMP_FOLDER ]] && rm -rf $OAH_INSTALLER_TMP_FOLDER

# rmdir ${OAH_INSTALLER_TMP_FOLDER}
