# gatsby

## how to use
1. create the image
    - run (from repository root): `bash ./tools/gatsby/build.sh`
2. create a new crna project
    - chang to a directory where you want to create the new crna project
    - run `docker run -it --rm -v $(pwd):/temp gatsby argument1 --arg-flag`
    - for more info run `docker run -it --rm -v $(pwd):/temp gatsby --help`

> the 8000 port is exposed, so if you want to use the gatsby server use `-p 8000:8000`
