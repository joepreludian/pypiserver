# PyPI Server

Simple Docker-compose file that runs pypiserver with simple authentication. Useful for being used with small projects.

# About PyPIserver

This project makes use of `pypiserver` docker image: [pypiserver at docker hub](https://hub.docker.com/r/pypiserver/pypiserver); It worth to take a look at the project README for more info, limitations and known issues.

# Requirements

In order to use this system, you need to have installed the following apps.

* Docker - Actually I'm using the latest version available.
* Docker Compose - In order to run the applicationl
* Apache Tools - because we are going to make use of `htpasswd`;

I tested it into a Linux box, but since you have the requirements installed into a Windows, it's totally possible to have this service running there without problems.

# Strucuture of this project

As soon as you run the project, you should see the following file structure:

```
├── authfile -> The htaccess file used to store credentials; It is generated through setup.sh
├── docker-compose.yml -> The docker-compose file with the needed configuration
├── packages -> A directory that it will store your PyPI packages
└── setup.sh -> The setup Script =)

```

# First Run

In order to make this project running at no time, please run the shellscript.

```
./setup.sh
PyPI Server Simple Repository Setup
Verifying if you have a credential file...
Not exists. Let's create one!
Please add a username: mypypiuser
New password: 
Re-type new password: 
Adding password for user mypypiuser
Now I need to run docker-compose. Can I move forward? [y/n] y
Running Docker-compose using the following config...
version: "3.7"

services:
  pypi:
    image: docker.io/pypiserver/pypiserver:latest
    environment:
      - PYTHONUNBUFFERED=1
    ports:
      - "8010:8080"
    volumes:
      - ./authfile:/data/.htpasswd
      - ./packages:/data/packages
    command: -a update,download,list -P /data/.htpasswd /data/packages
    restart: always
Creating network "pypiserver_default" with the default driver
Creating pypiserver_pypi_1 ... done
In order to authenticate yourself, use the credentials you provided in order to push, pull and query your brand new repo. Notice that it only works with HTTP protocol. Read the full README.md for more info. Thank you!
```

In a nutshell It will create an `authfile`, that is simply a htaccess file with a simple authentication. Also it will run a service under the port 8010, but notice that it will be served under HTTP protocol (no SSL support)


# Advanced topics

## Add SSL support

It is a good practice to use this server behind a nginx server. It's strongly recommended to keep this server behind a proxy, so you can secure it using it with an SSL server. Next time I will create an article how to achieve that;

## Backup

In order to get your project backed up please keep safe your `authfile` and `packages`. That's it.

# Needing support?

Please create an issue here. I will more than happy to help. Also feel free to collaborate too! Thank you!
