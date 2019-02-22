# Capone

Filter web server logs for addresses that have tried to hack us. Just as Al Capone was caught by incorrectly filling his taxes this application ignores complex analysis of the traffic from an address and says, "if they call `phpMyAdmin` ban them". Generally attackers are testing for a multitude of exploits so they will hit one of these soon enough

Obviously not perfect but a few simple rules will easily catch most of the script kiddies

But before anything. **This application works for me**. Which is why I wrote it

## Warning!!!

When it matches a line from your log file it assumes that the first element of the line is the ip address that the request is coming from. Works for me but might not work for you. Check your logs incase they are configured differently or they are behind a load balancer

## The config file

The process is driven by the config file `capone.yml`

```yaml
bad_actors:
    - phpMyAdmin
    - w00tw00t
    - GET http
    - CONNECT
    - index.php
    - setup.php
    - config.php
    - mysql
    - mySql
    - MySql
    - cgi
action:
    prefix: 'bh add'
    suffix: ''
```

The list of strings need not be long and complex and you quickly get diminishing returns. To be honest for me a lot of this could be replaced with `.php` as I don't run php apps

The actions section is what to do with the addresses it finds. In this example a string will be written to stdout for each address that it finds, `bh add X.X.X.X`. `bh` is a tool I use to manage my blacklist. This allows me to use the output to add the address to the blacklist using my preferred tool. If you are using `iptables` then you could use

```yaml
action:
    prefix: '/sbin/iptables -I INPUT -s'
    suffix: '-j DROP'
```
Or for `ufw`

```yaml
action:
    prefix: 'ufw insert 1 deny from'
    suffix: ''
```

Or just print out the addresses

```yaml
action:
    prefix: ''
    suffix: ''
```

Whatever works for you :)

## Usage

The basic usage is:

    $ capone --config /etc/capone.yml /var/log/nginx/access.log

Which will read the configuration from `/etc/capone.yml` and process the log file(s) given on the command line. When run it will output the list of addresses to ban to stdout

To list the lines that have been matched add the option `--debug yes` to the command line and the lines that matched will be written to stderr

It can also take input from stdin such as

    $ cat /var/log/nginx/access.log | capone --config /etc/capone.yml

## Installation

Included is a script, `install.sh` that will install `capone`, it's configuration file and a daily cron job. Things you might need to alter for your needs

0. How to ban addresses in `capone.yml`'s `action` section. See the notes above
1. Where your log files are located for the daily cron. I use nginx as a web server so my logs are here, `/var/log/nginx`
2. The `bad_actors` section of the config file, especially if you are running a PHP application

## Things to do

* An uninstall script
* Logging
* Determine the correct ip address to use
* The installer script to make some attempt to detecting your web server (and thus where your logs are)
