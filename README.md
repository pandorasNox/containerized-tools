# dockerized-tools

Collection of dockerized tools (tools whicht are running in in an docker container).

## Why?
Out there are a lot of build, task, bootstrapping and other tools.
I like all these tools but you find yourself use some of them extream rarely.
Even so rarely that you may just forget about them and that you installed a lot on your system.
So why not use docker and it's ability for auto removable containers to contain these tools.

## How to
0. You know docker and how to use it
1. you need to create the image
    - for this purpose I added a build.sh script to each tool folder which basicly runs `docker build` with predefined image names
    - e.g. run (from repository root): `bash tools/{toolname}/build.sh` to create a certain image
2. create and run the container with the `--rm` option and a mounted volume to `/temp`
    - e.g. run `docker run -it --rm -v $(pwd):/temp toolimagename customArgument`

> each tool also gots its own readme file for the case there is a special behavior for a certain tool

## List of tools

- create-react-native-app
- gatsby (-cli)
