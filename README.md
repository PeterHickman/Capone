# Capone

Filter web server logs for addresses that have tried to hack us. Just as Al Capone was caught by incorrectly filling his taxes this process ignores complex analysis of the traffic from an address and says, "if they call `phpMyAdmin` ban them". Generally attackers are testing for a multitude of exploits so they will hit one of these soon enough

Obviously not perfect but a few simple rules will easily catch most of the script kiddies

## The config file

For now the process is driven by the config file called `capone.yml` and stored in the same location as the scrfipt is being run from. This will change as the project progresses

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

The list of strings need not be long and complex and it get diminishing returns quite quickly. 