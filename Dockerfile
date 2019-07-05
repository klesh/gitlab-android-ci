FROM openjdk:8-jdk
MAINTAINER Klesh Wong
LABEL version="0.2"
LABEL description="gitlab CI/CD docker image for Android app building/testing/deployment"

ENV ANDROID_COMPILE_SDK "28"
ENV ANDROID_BUILD_TOOLS "28.0.2"
ENV ANDROID_SDK_TOOLS "4333796"
ENV ANDROID_HOME=$PWD/android-sdk-linux
ENV PATH=$PATH:$PWD/android-sdk-linux/platform-tools/:$PWD/android-sdk-linux/build-tools/28.0.2


COPY ./sources.list /etc/apt/

RUN apt-get clean
RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1
RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
RUN unzip -d android-sdk-linux android-sdk.zip
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null
RUN yes | android-sdk-linux/tools/bin/sdkmanager --licenses
RUN rm android-sdk.zip
RUN apt-get -qy autoremove
