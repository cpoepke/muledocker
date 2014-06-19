# Dockerizing Mule CE
# Version:  3.5
# Based on:  dockerfile/java (Trusted Java from http://java.com)

FROM                    dockerfile/java:latest
MAINTAINER              Eugene Ciurana <muledocker@eugeneciurana.com>

# Mule installation:
RUN                     echo "Fetching Mule - this may take a few minutes"
ADD                     https://repository.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/3.5.0/mule-standalone-3.5.0.tar.gz /opt/
RUN                     tar -C /opt -xzvf /opt/mule-standalone-3.5.0.tar.gz
RUN                     ln -s /opt/mule-standalone-3.5.0 /opt/mule
RUN                     rm -f /opt/mule-standalone-3.5.0.tar.gz


# TODO:  Jython installation:



# Configure external access:

# Mule remote debugger
EXPOSE  5000

# Mule JMX port (must match Mule config file)
EXPOSE  1098

# Default port for HTTP endpoints in AnypointStudio
EXPOSE  8081    


# Environment and execution:

ENV             MULE_BASE=/opt/mule

CMD             /opt/mule/bin/mule

