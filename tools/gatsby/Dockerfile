FROM node:8.9.1-alpine

RUN npm install -g gatsby-cli@1.1.25

EXPOSE 8000

ENTRYPOINT cd /temp && gatsby

# ========== EXPECT ========== #

# EXPECT -v some/path:/temp
