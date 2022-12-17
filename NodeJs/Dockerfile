FROM  node:slim

WORKDIR /home/node/app
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

#Install APP Depencencies
COPY package.json ./

# RUN as a node user
USER node
RUN npm install

#Copy APP
COPY --chown=node:node . .

#Expose Port 8080 to outside world
EXPOSE 8080

CMD ["node", "index.js"]

