
FROM node:10.14.2-alpine

RUN yarn global add create-elm-app@2.2.4

COPY ./entrypoint.sh /
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# ========== EXPECT ========== #

# EXPECT -v some/path:/temp
