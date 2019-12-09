FROM node:8-onbuild
EXPOSE 8080
COPY server.js .
CMD node server.js
