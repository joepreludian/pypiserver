#!/bin/bash

AUTHFILE='authfile'

echo "PyPI Server Simple Repository Setup"
echo "Verifying if you have a credential file..."

if [ -e authfile ]; then
  echo "File exists. Skipping."
else
  echo "Not exists. Let's create one!"
  echo -n "Please add a username: "
  read auth_user
  htpasswd -sc "$AUTHFILE" "$auth_user"
fi

docker-compose ps | grep pypi | grep Up > /dev/null

if [ $? -eq 0 ]; then
  echo "The docker-compose seems to be running already. We're good!"
  exit 0
fi

echo -n "Now I need to run docker-compose. Can I move forward? [y/n] "
read do_continue

if [ "$do_continue" != "y" ]; then
  echo "Stopping here. You just need to run docker-compose up -d"
  exit 1
fi

echo "Running Docker-compose using the following config..."
cat docker-compose.yml

docker-compose up -d

echo "In order to authenticate yourself, use the credentials you provided in order to push, pull and query your brand new repo. Notice that it only works with HTTP protocol. Read the full README.md for more info. Thank you!"
