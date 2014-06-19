[TOC]

## Build the Image

```bash
$DOCKER_HUB_USER_NAME="pr3d4t0r"

docker build -t "$DOCKER_HUB_USER_NAME" .
```

## Publish the Image to Docker Hub

TBD


## Java and Python Mule Examples

This configuration includes two test examples to validate that the Mule installation
is ready for deployment.

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



