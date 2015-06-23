#!/bin/bash
GIT_REPO=/var/repository
TMP_GIT_CLONE=/tmp/repocopy
PUBLIC_WWW=/var/www/html/

git clone $GIT_REPO $TMP_GIT_CLONE > /dev/null
sudo -u www-data jekyll build --source $TMP_GIT_CLONE --destination $PUBLIC_WWW
rm -Rf $TMP_GIT_CLONE
exit
