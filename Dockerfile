FROM node:16
RUN npm i -g npm && \
  npm install -g eas-cli

# Install OpenJDK

RUN apt-get update && \
  apt-get install default-jre default-jdk -y

# Download and setup Android SDK, and set $ANDROID_HOME var

WORKDIR /tmp
RUN curl -o cmdline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-9123335_latest.zip && \
  unzip cmdline-tools.zip

WORKDIR /home/ubuntu

ENV ANDROID_HOME=/home/ubuntu/android_sdk
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

RUN mkdir -p android_sdk/cmdline-tools/latest && \
  mv /tmp/cmdline-tools/* android_sdk/cmdline-tools/latest && \
  rm /tmp/cmdline-tools.zip

# Accept all licensed
RUN yes | sdkmanager --licenses

# Pre-install necessary packages
RUN sdkmanager --install "patcher;v4" && \
  sdkmanager --install "ndk;23.1.7779620" && \
  sdkmanager --install "cmake;3.22.1" && \
  sdkmanager --install "emulator" && \
  sdkmanager --install "platform-tools" && \
  sdkmanager --install "tools" && \
  sdkmanager --install "build-tools;30.0.3" && \
  sdkmanager --install "platforms;android-33"
