#!/bin/bash

echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

build_and_push () {

  export TAG=`if [ "$TRAVIS_BRANCH" == "master" ]; then echo "latest"; else echo $TRAVIS_BRANCH ; fi`
  docker build -t $DOCKER_USER/$1:$COMMIT -f $1/Dockerfile $1
  docker tag $DOCKER_USER/$1:$COMMIT $DOCKER_USER/$1:$TAG
  docker tag $DOCKER_USER/$1:$COMMIT $DOCKER_USER/$1:travis-$TRAVIS_BUILD_NUMBER
  docker push $DOCKER_USER/$1

}

for repo in base-notebook-gpu minimal-notebook-gpu scipy-notebook-gpu tensorflow-notebook-gpu ;
  do
    build_and_push $repo
  done
