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


# An annoying error message keeps appearing unless you do this.
run    dpkg-divert --local --rename --add /sbin/initctl
run    ln -s /bin/true /sbin/initctl


# Download and install everything from the repos.
add    ./apt/sources.list /etc/apt/sources.list
run    apt-get --yes update; apt-get --yes upgrade
run	   apt-get --yes install unzip


# Install Starbound
run    mkdir -p /opt/starbound
add    ./starbound/starbound.zip /opt/starbound/starbound.zip
run    cd /opt/starbound; unzip starbound.zip; chmod +x /opt/starbound/linux64/starbound_server


# Load in all of our config files.
add    ./scripts/start /start


# Fix all permissions
run    chmod +x /start


# /start runs it.
expose 21025
cmd    ["/start"]
