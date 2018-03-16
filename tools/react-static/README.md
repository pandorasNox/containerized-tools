# create-react-app

## how to use
1. create the image
    - run (from repository root): `bash ./tools/create-react-app/build.sh`
2. create a new cra project
    - run `docker run -it --rm -v $(pwd):/temp react-static --help` for some infos
    - chang to a directory where you want to create the new crna project
    - run `docker run -it --rm -v $(pwd):/temp react-static create`
    - an installation wizzard should guide you
