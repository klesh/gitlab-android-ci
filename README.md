# Introduction

gitlab CI/CD docker image for Android app building/testing/deployment


# Build and push docker image
```sh
docker build -t android-ci:v2 .
docker push android-ci:v2
```

# Configurate your android apk repository
Edit your `.gitlab-ci.yml`, here is an example
```
image: android-ci:v2

variables:
  ANDROID_COMPILE_SDK: "28"
  ANDROID_BUILD_TOOLS: "28.0.2"
  ANDROID_SDK_TOOLS:   "4333796"

before_script:
  - export GRADLE_USER_HOME=$PWD/.gradle
  - chmod +x ./gradlew

cache:
  paths:
     - .gradle/wrapper
     - .gradle/caches

stages:
  - build
  - test

#lintDebug:
  #stage: build
  #script:
    #- ./gradlew -Pci --console=plain :app:lintDebug -PbuildDir=lint

assembleDebug:
  stage: build
  script:
    - ./gradlew assembleDebug
  artifacts:
    paths:
    - app/build/outputs/

debugTests:
  stage: test
  script:
    - ./gradlew -Pci --console=plain :app:testDebug
```
