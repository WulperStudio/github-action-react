FROM    node:latest
EXPOSE  4000
ADD     . /app/
WORKDIR /app
RUN     npm install --only=prod
RUN     npm run build
CMD     [ "npm", "start" ]
