# Flask App container with MySQL Database

## Quick Start

  1. Run `docker-compose up`
  2. Visit `http://localhost:5000` in your browser.

## Description

[Flask](http://flask.pocoo.org/) is a web development microframework for Python.

Docker compose will create two containers linked together, one for Flask and one for MySQL

## Persisting Data

This setup will persist data on a separate `/var/lib/mysql` volume.

This is setup in `docker-compose.yml` file:

    services:
      ...
      db:
        ...
        volumes:
          - /var/lib/mysql

You can also mount a directory on the host as a volume using the syntax `[host-path]:[container-path]`, so if you want to mount a `data` dir in the project folder as `/var/lib/mysql`, it can be specified like follows:

    services:
      ...
      db:
        ...
        volumes:
          - ./database:/var/lib/mysql

containers are immutable so after changing any settings, containers need to be stopped, removed and recreated
