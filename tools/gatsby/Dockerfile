FROM node:8.9.1-alpine

RUN npm install -g gatsby-cli@1.1.45

RUN apk --update add git openssh && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

EXPOSE 8000

COPY ./entrypoint.sh /
RUN chmod +x entrypoint.sh
# ENTRYPOINT cd /temp && gatsby
ENTRYPOINT ["/entrypoint.sh"]

# ========== EXPECT ========== #

# EXPECT -v some/path:/temp
