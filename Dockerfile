#official nodejs application image
FROM node:14

#setting up a working directory for the application
WORKDIR /usr/src/app

#Copying application files in the container
COPY package*.json ./
COPY app.js ./

#Install any required packages
RUN npm install

#Make port 3000 available for the container to access it outside world
EXPOSE 3000

#Run the application in the container
CMD [ "npm", "start" ]
