# =============================
#         Build Phase
# =============================
FROM node:alpine AS builder

# USER node

# RUN mkdir -p /home/projects/client

WORKDIR /home/projects/client

COPY package.json .
COPY package-lock.json .

RUN npm ci

COPY . .

RUN npm run build
# =============================

# =============================
#         Run Phase
# =============================
FROM nginx

COPY --from=builder /home/projects/client/build /usr/share/nginx/html 