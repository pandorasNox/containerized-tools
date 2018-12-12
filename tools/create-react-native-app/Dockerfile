FROM node:10.14.2-alpine

RUN npm install -g create-react-native-app@1.0.0

COPY ./entrypoint.sh /
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# ========== EXPECT ========== #

# EXPECT -v some/path:/temp
