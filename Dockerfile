# -----------------------------------------------------------------------------
# docker-starbound
#
# Builds a basic docker image that can run Starbound
# (http://playstarbound.com/).
#
# Authors: Isaac Bythewood
# Updated: Jan 26th, 2014
# Require: Docker (http://www.docker.io/)
# -----------------------------------------------------------------------------


# Base system is the LTS version of Ubuntu.
from   ubuntu:12.04


# Make sure we don't get notifications we can't answer during building.
env    DEBIAN_FRONTEND noninteractive


# Download and install everything from the repos.
add    ./apt/sources.list /etc/apt/sources.list
run    apt-get --yes update; apt-get --yes upgrade
run	   apt-get --yes install unzip libc6:i386 libgcc1:i386 gcc-4.6-base:i386 libstdc++5:i386 libstdc++6:i386


# Install Starbound
run    mkdir -p /opt/starbound
add    ./starbound/starbound.zip /opt/starbound/starbound.zip
run    cd /opt/starbound; unzip starbound.zip; rm /opt/starbound/starbound.zip; chmod +x /opt/starbound/linux32/starbound_server
add    ./starbound/linux32/bootstrap.config /opt/starbound/linux32/bootstrap.config


# Load in all of our config files.
add    ./scripts/start /start


# Fix all permissions
run    chmod +x /start


# /start runs it.
expose 21025
cmd    ["/start"]

