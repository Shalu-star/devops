FROM node:14-alpine

ADD . /app

WORKDIR /app

COPY package.json ./

RUN npm install

COPY . .

EXPOSE 3000:3000

CMD npm start 