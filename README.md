# Capone

Filter web server logs for addresses that have tried to hack us. Just as Al Capone was caught by incorrectly filling his taxes this process ignores complex analysis of the traffic from an address and says, "if they call `phpMyAdmin` ban them". Generally attackers are testing for a multitude of exploits so they will hit one of these soon enough

Obviously not perfect but a few simple rules will easily catch most of the script kiddies

## The config file

For now the process is driven by the config file called `capone.yml` and stored in the same location as the script is being run from. This will change as the project progresses

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

The list of strings need not be long and complex and it gets diminishing returns quite quickly. To be honest for me a lot of this could be replaced with `.php` as I don't run php apps

The actions section is what to do with the addresses it finds. In this example a string will be written to stdout for each address that it finds, `bh add X.X.X.X`. `bh` is a tool I use to manage my blacklist. This allows me to use the output to add the address to the  blacklist using my preferred tool. If you are using `iptables` then you could use

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

Whatever works for you :)

## Usage

The basic usage is:

    $ capone --config /path/to/config.yml /var/log/nginx/access.log

Which will read the configuration from `/path/to/config.yml` and process the log file(s) given on the command line. When run it will output the list of addresses to ban to stdout

To list the lines that have been matched add the option `--debug yes` to the command line and the lines that matched will be written to stderr

It can also take input from stdin such as

    $ cat /var/log/nginx/access.log | capone --config /path/to/config.yml

