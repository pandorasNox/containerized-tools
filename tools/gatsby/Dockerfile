FROM node:6.11.4-alpine

RUN npm install -g gatsby-cli@1.1.8

ENTRYPOINT cd /temp && gatsby

# ========== EXPECT ========== #

# EXPECT -v some/path:/temp
