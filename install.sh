#!/bin/sh

if ! [ "$(id -u)" = 0 ]; then
  echo 'You must be root to do this.' 1>&2
  exit 1
fi

##
# When installing we would install as root, however on
# BSD based systems (such as OSX) this is not a valid
# group / user for install so we use the numberic value
##
ROOT="0"

echo "Installing capone into /usr/local/sbin/"
install -g $ROOT -o $ROOT -m 0755 capone /usr/local/sbin/

if [ -r "/etc/capone.yml" ]; then
  echo "Cowardly, will not overwrite existing capone.yml"
else
  echo "Installing capone.yml into /etc/"
  install -g $ROOT -o $ROOT -m 0644 capone.yml /etc/
fi

echo "Installing cron into daily"
install -g $ROOT -o $ROOT -m 0755 cron.daily /etc/cron.daily/capone
