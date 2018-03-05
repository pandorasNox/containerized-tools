
# gatsby

## how to use
1. create the image
    - run (from repository root): `bash ./tools/gatsby/build.sh`
2. create a new gatsby project
    - chang to a directory where you want to create the new gatsby project
    - run `docker run -it --rm -v $(pwd):/temp gatsby argument1 --arg-flag`
    - for more info run `docker run -it --rm -v $(pwd):/temp gatsby --help`

> the 8000 port is exposed, so if you want to use the gatsby server use `-p 8000:8000`

## development
In order to run the development command you have to add the `-H` flag and specify `0.0.0.0` as host, bec there is a a port mapping problem with webpack

Also HMR is only working if you are using the same ports in docker and in gatsby (e.g. for docker add: -p 8978:8978 and for gatsby add: -p 8978)

command: `docker run -it --rm -p 8978:8978 -v $(pwd):/temp gatsby develop -p 8978 -H 0.0.0.0`

if your port 8000 is free the docker port part with `-p 8000:8000` is enough
