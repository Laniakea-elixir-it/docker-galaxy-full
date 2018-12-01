docker-galaxy-minimal
=======================
Galaxy with CernVM-FS repository providing reference data.

To correctly load the reference data (through CernVM-FS) you need to run this docker in privileged mode:
```
sudo docker run --privileged -d -p 80:80 -p 21:21 laniakeacloud/galaxy-minimal
```

Build local docker image
------------------------

```
$ docker build -t galaxy-minimal --no-cache .
```

Run docker image in privileged mode to load cmvfs reference data:

```
$ sudo docker run --privileged -d -t -i -p 80:80 -p 21:21 galaxy-minimal
```

Default user
------------
To access Galaxy the default administrator user is:
```
GALAXY_ADMIN_EMAIL: "admin@elixir-italy.org"
GALAXY_ADMIN_USERNAME: "admin"
```

Galaxy version
--------------
Current Galaxy version:
```
GALAXY_VERSION: "release_18.05"
```
