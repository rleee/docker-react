FROM node:alpine as builder 
# as builder is to rename this process
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
# EXPOSE 80 for exposing the port for aws beanstalk and map for incoming traffic
COPY --from=builder /app/build /usr/share/nginx/html