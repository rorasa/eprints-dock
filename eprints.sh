#!/bin/bash

runId="$(docker ps -q -f 'name=eprints')"
conId="$(docker ps -aq -f 'name=eprints')"

echo $0 $1
if [ "$1" == "remove" ]
then
    if [ -n "$conId" ]
    then
        echo "Removing eprints container"
        docker stop $conId
        docker rm $conId
    fi
    exit
elif [ "$1" == "remove-image" ]
then
    if [ -n "$conId" ]
    then
        echo "Removing eprints container"
        docker stop $conId
        docker rm $conId
    fi
    docker rmi rorasa/eprints3
    exit
elif [ "$1" == "stop" ]
then
    if [ -n "$conId" ]
    then
        echo "Stoping eprints server"
        docker stop $conId
    fi
    exit
elif [ "$1" == "start" ]
then
    if [ -z "$conId" ]
    then
        echo "Creating new eprints container"
        docker run --name eprints -p 80:80 -v $PWD/eprints3/archives:/usr/share/eprints3/archives -v $PWD/eprints3/cfg:/usr/share/eprints3/cfg -v $PWD/mysql:/var/lib/mysql -t -i rorasa/eprints3
    else
        echo "Resuming eprints server"
        docker start $conId
    fi
    exit
fi

if [ -n "$runId" ]
then
    echo "Stoping eprints server"
    docker stop $runId
    exit
fi

if [ -z "$conId" ]
then
    docker run --name eprints -p 80:80 -v $PWD/eprints3/archives:/usr/share/eprints3/archives -v $PWD/eprints3/cfg:/usr/share/eprints3/cfg -v $PWD/mysql:/var/lib/mysql -t -i rorasa/eprints3
else
    echo "Resumimg eprints server"
    docker start $conId
fi
