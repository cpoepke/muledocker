# Mule Docker Image

This project defines the Dockerfile and supporting tools for packaging and deploying
a complete, operational version of Mule using Docker.


## Launching the MuleCE 3.6 Container

A Mule CE container can be shipped with a bundled Mule application or users may hot deploy applications
just like when Mule runs in the native system.


### Deploying a Mule Application Container

The Dockerfile only has two relevant lines!  FROM and ADD; everything else comes from pr3d4t0r/mule:

```bash
FROM                    pr3d4t0r/mule:latest
.
.
ADD                     mule-docker-test-a/target/mule-docker-test-a-1.0.0-SNAPSHOT.zip /opt/mule-standalone-3.6.1/apps/
```

Build the new image:

```bash
docker build -t "$DOCKER_HUB_USER_NAME"/embeddedmuleapp .
```

Run the app:

```bash
docker run -p 8081:8081 -t -i --name='embeddedmuleapp' "$DOCKER_HUB_USER_NAME"/embeddedmuleapp
```

Notice that the port 8081 was defined in the outer container, under pr3d4t0r/mule -- there's no need to
define it here again.  If the app opens other ports, EXPOSE them in this app's Dockerfile.

Last, test:

```bash
curl http://192.168.59.103:8081/test_a
```

That's the container's IP address, which may be obtained via `docker ip`.  If all went well, the app
will output:

```javascript
{"application":"Mule Docker - Test A","language":"Java","version":"1.7.0_55"}
```

Done!


### Hot Deployment of a Mule Application 

Mule supports hot application deployment.  This is done by dropping the application bundle to the 
`$MULE_BASE/apps` directory, from where the server will automagically load and execute the app.

To do that, the Mule container must map its internal apps directory to a host's designated
directory.  This project includes a sample directory, `muleapps`, that will be linked to the
container for hot deployment.

Ensure that the `muleapps` directory exists:

```bash
mkdir -p muleapps
```

Launch the pr3d4t0r/mule container.  Ensure that the `muleapps` directory is mounted as a volume in the `$MULE_BASE/apps`
path on the server!  Also, -v requires an absolute path of it won't find it.

```bash
docker run -p 8090:8090 -t -i  --name='mule' -v "$HOME/muleapps":/opt/mule-standalone-3.6.1/apps/ pr3d4t0r/mule
```

Once Mule is running, copy the Mule app (Python test app B in our example) from wherever it is in the file system to
the `$HOME/muleapps` directory:

```bash
sleep 3; cp testapps/mule-docker-test-b/target/mule-docker-test-b-1.0.0-SNAPSHOT.zip muleapps/
```

Last, test the endpoint:

```bash
curl http://192.168.59.103:8090/test_b
```

That's the container's IP address, which may be obtained via `docker ip`.  If all went well, the app
will output:

```javascript
{"version":"2.7","application":"Mule Docker - Test B","language":"Python"}
```

Notice that test apps A and B may be running in the Mule server at the same time.  Apps are loaded in
independent contexts and each app's connectors will bind to specific ports; two individual apps can't
bind to the same port, that's why test A is open on port 8081, test B is open on port 8090.

<pre>
*******************************************************************************************************
*            - - + APPLICATION + - -            *       - - + DOMAIN + - -       * - - + STATUS + - - *
*******************************************************************************************************
* mule-docker-test-a-1.0.0-SNAPSHOT             * default                        * DEPLOYED           *
* mule-docker-test-b-1.0.0-SNAPSHOT             * default                        * DEPLOYED           *
*******************************************************************************************************
</pre>

Done!

===

This section contains miscellaneous information and it's under construction:


## TODO:  Document the shared volume mount under OS X and the `mountb2dfs` tool


## Publish the Image to Docker Hub

```bash
DOCKER_HUB_MULE_TAB="3.6"
docker push "$DOCKER_HUB_USER_NAME"/mule:"$DOCKER_HUB_MULE_TAB"
```


## Java and Python Mule Examples

This configuration includes two test examples to validate that the Mule installation
is ready for deployment.


### Java Work Flow

<img src='https://s3.amazonaws.com/0921ccnz33vh1pvcmg02.images/cdn/MuleDockerJavaTestA.png' />


### Python Work Flow

<img src='https://s3.amazonaws.com/0921ccnz33vh1pvcmg02.images/cdn/MuleDockerPythonTestB.png' />



### Build the Test Mule Apps

Run these commands:

```bash
pushd testapps/mule-docker-test-a/ ; mvn -Dmaven.test.skip=true clean package ; popd
pushd testapps/mule-docker-test-b/ ; mvn -Dmaven.test.skip=true clean package ; popd
```

The first command builds a Java app, the second one a Python app.  Both define flows with
a single endpoint that responds with the the test app name, language, and version.

Validate that both Maven builds completed well by running:

```bash
find testapps/ -name mule-docker*zip
```


#### Build the Test Mule Apps in AnypointStudio

1. Open AnypointStudio
2. Close all open projects
3. Right click on the package manager and select Import...
4. Select Mule
5. Select Import from Mule Maven Project
6. Respond to the prompts according to your system setup
7. Click Finish
8. Done!


The section on writing and deploying the code describes in detail how to start the
Mule container and how the applications are deployed to it.


## Support Commands

These utilities just make life a bit easier during image and container
development and testing.


### czap
Syntax:

```bash
czap "$containerName"
```

Zaps a container out of existence by stopping its execution and
removing it from the registry.  It uses the container name.


### izap
Syntax:

```bash
izap "$image"
```

Zaps an image out of existence by removing it from the local
repository.  It uses the image ID or the image name.  There is
no need to escape the / in the name.


### Aliases

Some helpful aliases that you may want to use:

List all containers (running and stopped):

```bash
alias cls='docker ps -a'
```


Remove a container:

```bash
alias crm='docker rm'
```


List all images in the local store, including the intermediate ones:

```bash
alias ils='docker images -a'
```


Remove an image:

```bash
alias irm='docker rmi'
```



