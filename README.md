# docker-starbound

A nice and easy way to get a Starbound server up and running using docker. For
help on getting started with docker see the [official getting started guide][0].
For more information on Starbound and check out it's [website][1].


## Building docker-starbound

Running this will build you a docker image with the latest version of both
docker-starbound and Starbound itself.

    git clone https://github.com/overshard/docker-starbound
    cd docker-starbound
    docker build -t overshard/starbound .


## Running docker-starbound

Running the first time will set your port to a static port of your choice so
that you can easily map a proxy to. If this is the only thing running on your
system you can map the ports to 21025 and no proxy is needed. i.e.
`-p=21025:21025` Also be sure your mounted directory on your host machine is
already created before running `mkdir -p /mnt/starbound`. Also note that you
must have your host mount directory created first
(``mkdir -p /mnt/starbound``)::

    sudo docker run -d=true -p=21025:21025 -v=/mnt/starbound:/data overshard/starbound /start

From now on when you start/stop docker-starbound you should use the container id
with the following commands. To get your container id, after you initial run
type `sudo docker ps` and it will show up on the left side followed by the image
name which is `overshard/starbound:latest`.

    sudo docker start <container_id>
    sudo docker stop <container_id>


### Notes on the run command

 + `-v` is the volume you are mounting `-v=host_dir:docker_dir`
 + `overshard/starbound` is simply what I called my docker build of this image
 + `-d=true` allows this to run cleanly as a daemon, remove for debugging
 + `-p` is the port it connects to, `-p=host_port:docker_port`


[0]: http://www.docker.io/gettingstarted/
[1]: http://starbound.com/

