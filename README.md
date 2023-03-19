# expo-android-build-docker

Use this base image to setup the environment needed to build Expo Android apps.

## Usage

Use this as your base image

```Dockerfile
FROM ghcr.io/psnehanshu/expo-android-build-docker:main

# Do the rest here, like copy the souce code

# You can trigger the build like this
CMD eas build --platform android --local
```

Now you can use `docker build` command to build you image. After that, you can use `docker run` to run the container that will actually build the app.
