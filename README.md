# Mule Docker Image

This project defines the Dockerfile and supporting tools for packaging and deploying
a complete, operational version of Mule using Docker.


## Build the Image

```bash
DOCKER_HUB_USER_NAME="pr3d4t0r"

docker build -t "$DOCKER_HUB_USER_NAME" .
```

## Publish the Image to Docker Hub

```bash
DOCKER_HUB_MULE_TAB="3.5"
docker push "$DOCKER_HUB_USER_NAME"/mule:"$DOCKER_HUB_MULE_TAB"
```


## Launching the MuleCE 3.5 Container

```bash
mkdir -p container_apps

APPS_VOL="/opt/mule-standalone-3.5.0/apps/"
LOCAL_APPS_VOL="container_apps"

docker run -d --name="mule" -v "$APPS_VOL":"$LOCAL_APPS_VOL" "$DOCKER_HUB_USER_NAME"/mule:"$DOCKER_HUB_MULE_TAB"
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



