FROM node:16
RUN npm install -g eas-cli

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
RUN sdkmanager --install "patcher;v4" 
RUN sdkmanager --install "ndk;21.4.7075529" 
RUN sdkmanager --install "cmake;3.18.1" 
RUN sdkmanager --install "emulator" 
RUN sdkmanager --install "platform-tools" 
RUN sdkmanager --install "tools" 
RUN sdkmanager --install "build-tools;30.0.3" 
RUN sdkmanager --install "platforms;android-31"
