FROM node:6.11.4-alpine

RUN npm install -g create-react-native-app@0.0.6

COPY ./entrypoint.sh /
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# ========== EXPECT ========== #

# EXPECT -v some/path:/temp
