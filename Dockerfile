FROM node:12

COPY ./action.sh /action.sh

ENTRYPOINT [ "/action.sh" ]