FROM node:8-onbuild
EXPOSE 8000
COPY server.js .
CMD node server.js
