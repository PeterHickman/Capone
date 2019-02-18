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

The actions section is what to do with the addresses it finds. In this example the string each found address will be written to stdout as `bh add X.X.X.X`. `bh` is a tool I use to manage my blacklist. This allows 