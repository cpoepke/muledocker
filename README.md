## muledocker

Lorem ipsum, dolot sit hamet...
===


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
````

Zaps an image out of existence by removing it from the local
repository.  It uses the image ID or the image name.  There is
no need to escape the / in the name.

