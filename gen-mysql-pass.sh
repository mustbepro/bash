#!/bin/bash

mysqlpwd=$(/usr/bin/python -c 'from hashlib import sha1; import getpass; print "*" + sha1(sha1(getpass.getpass("New MySQL Password:")).digest()).hexdigest()')

echo "$mysqlpwd" | awk '{print toupper($0)}' > ./.mysql-hash
