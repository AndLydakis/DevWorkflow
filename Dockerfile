# base image and tag
FROM node:alpine

# no need to use volumes as production envs
# assume no code changes
WORKDIR '/app'
COPY /frontend/package*.json ./
RUN npm install
COPY frontend .

# production code will be located in
# /app/build
RUN npm run build

# Second phase
FROM nginx
# Open nginx default port
EXPOSE 80
# copy from tagged stage to destination (nginx specific here)
COPY --from=0 /app/build /usr/share/nginx/html
