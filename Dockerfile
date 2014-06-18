# Initial/training Docker file

FROM ubuntu:14.04
MAINTAINER Eugene Ciurana <dockerspam@cime.net>
RUN apt-get -qq update
RUN apt-get -qqy install ruby ruby-dev
RUN gem install sinatra

