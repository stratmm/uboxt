# This file creates the Docker image for the current working version of the Bilcas
# api. It is a self-contained image, requiring all of the application dependencies
# and gems.

# Start with a base Ubuntu 14:04 image
FROM ubuntu:trusty

MAINTAINER Mark Stratmann <mark@stratmann.me.uk>

# Add all base dependencies
RUN apt-get update
RUN apt-get -y install python-software-properties wget openssl libreadline6 libreadline6-dev curl git zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion zlib1g-dev build-essential libreadline-dev libsqlite3-dev libxml2-dev libxslt1-dev
RUN apt-get install -y vim

# Install RVM
RUN curl -L get.rvm.io | bash -s stable
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Install Ruby
RUN /bin/bash -l -c "rvm install 2.1.2"
RUN /bin/bash -l -c "rvm use 2.1.2"

# Setup the working directory
WORKDIR /project

# Add the application to the container (cwd)
ADD ./ /project


# Create Gemset
RUN /bin/bash -l -c "rvm gemset create uboxt"
RUN /bin/bash -l -c "rvm use 2.1.2@uboxt --default"

# You will need your github ssh key
ADD ./ssh/ /root/.ssh
RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

# Add dependecies for Ruby project
RUN apt-get install -y postgresql-client libpq5 libpq-dev

# Install the bundle
RUN /bin/bash -l -c "bundle install"


VOLUME ["/project"]

# Setup the entrypoint
ENTRYPOINT ["/bin/bash", "-l", "-c"]
CMD ["bundle exec rails s"]
