#!/bin/bash

docker run --name eprints -p 80:80 -v $PWD/eprints3/archives:/usr/share/eprints3/archives -v $PWD/eprints3/cfg:/usr/share/eprints3/cfg -v $PWD/mysql:/var/lib/mysql -t -i rorasa/eprints3
