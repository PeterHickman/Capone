#!/bin/sh

if ! [ "$(id -u)" = 0 ]; then
  echo 'You must be root to do this.' 1>&2
  exit 1
fi

remove()
{
  P=`dirname $1`
  F=`basename $1`

  if [ -r "$1" ]; then
    echo "Removing $F from $P"
    rm $1
  else
    echo "$F already removed from $P"
  fi
}

remove "/usr/local/sbin/capone"
remove "/etc/capone.yml"
remove "/etc/cron.daily/capone"
