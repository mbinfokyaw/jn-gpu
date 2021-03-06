#!/bin/bash

echo "Logging in..."
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
echo "Building and pushing..."

build_and_push () {

  export TAG=`if [ "$TRAVIS_BRANCH" == "master" ]; then echo "latest"; else echo $TRAVIS_BRANCH ; fi`
  docker build -t $DOCKER_USERNAME/$1:$COMMIT -f $1/Dockerfile $1
  
  if [ -z ${TRAVIS_TAG} ]; then
    echo "Tag Docker image with Git tag $TRAVIS_TAG"
    docker tag $DOCKER_USERNAME/$1:$COMMIT $DOCKER_USERNAME/$1:$TRAVIS_TAG; 
  else 
    echo "No tag supplied."; 
  fi
  
  docker tag $DOCKER_USERNAME/$1:$COMMIT $DOCKER_USERNAME/$1:$TAG
  docker tag $DOCKER_USERNAME/$1:$COMMIT $DOCKER_USERNAME/$1:travis-$TRAVIS_BUILD_NUMBER
  docker push $DOCKER_USERNAME/$1

}

build_and_push $1
