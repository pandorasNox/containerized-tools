FROM node:8.10.0-alpine

RUN npm install -g react-static@5.6.1

COPY ./entrypoint.sh /
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# ========== EXPECT ========== #

# EXPECT -v some/path:/temp
