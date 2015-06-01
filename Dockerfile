# Dockerizing Mule CE
# Version:  3.6
# This is a fork with an updated Mule Version
# Based on:  dockerfile/java (Trusted Java from http://java.com)

FROM                    java:7
MAINTAINER              Eugene Ciurana <muledocker@eugeneciurana.com>


# Mule installation:

ADD                     https://repository.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/3.6.1/mule-standalone-3.6.1.tar.gz /opt/
WORKDIR                 /opt
RUN                     tar -xzvf /opt/mule-standalone-3.6.1.tar.gz
RUN                     ln -s mule-standalone-3.6.1 mule
# Remove things that we don't need in production:
RUN                     rm -f mule-standalone-3.6.1.tar.gz
RUN                     rm -Rf mule/apps/default*
RUN                     rm -Rf mule/examples


# Jython installation:
# NOTE:  Using Jython 2.7 beta 2; it's good enough for all our purposes.  The beta files come down with a weird
#        name due to a redirect via maven.org - no worries, this can be fixed later.
# 
RUN                     wget http://search.maven.org/remotecontent?filepath=org/python/jython-standalone/2.7-b2/jython-standalone-2.7-b2.jar
RUN                     mv $(ls | awk '/remote/') /opt/mule-standalone-3.6.1/lib/opt/jython-standalone-2.7-b2.jar


# TODO:  If anyone cares, they may add the Groovy and JavaScript run-times;
#        they're also out of date.  See:
#        http://eugeneciurana.com/site.php?page=musings&contentTag=Anypoint-Jython.html


# Configure external access:

# Mule remote debugger
EXPOSE  5000

# Mule JMX port (must match Mule config file)
EXPOSE  1098

# Default port for HTTP endpoints in AnypointStudio
EXPOSE  8081    

# Alternate pr3d4t0r HTTP default endpoint
EXPOSE  8090


# Environment and execution:

ENV             MULE_BASE /opt/mule
WORKDIR         /opt/mule-standalone-3.6.1

CMD             /opt/mule/bin/mule

