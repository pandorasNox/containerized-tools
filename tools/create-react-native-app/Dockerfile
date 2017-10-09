FROM node:6.10.3-alpine

COPY ./entrypoint.sh /
RUN chmod +x entrypoint.sh \
    && npm install -g create-react-native-app@0.0.6

# EXPECT mounted volume in /temp

ENTRYPOINT ["/entrypoint.sh"]

# docker build -t crna ./docker/crna/
# docker run -ia --rm -v $(pwd):/temp crna
#sh -c "crna-init.sh"
