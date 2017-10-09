# create-react-native-app

## how to use
1. create the image
    - run (from repository root): `bash ./tools/create-react-native-app/build.sh`
2. create a new crna project
    - chang to a directory where you want to create the new crna project
    - run `docker run -it --rm -v $(pwd):/temp create-react-native-app MyNewCRNApp` while the last parameter is just a custom name for the directory
