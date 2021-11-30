FROM node:16.13.0-alpine

ARG WORKDIR
ARG API_URL

ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    # コンテナのNuxt.jsをブラウザから参照させるためにip:0.0.0.0に紐つける
    # 他の指定方法はhttps://develop365.gitlab.io/nuxtjs-2.8.X-doc/ja/faq/host-port/
    HOST=0.0.0.0 \
    API_URL=${API_URL}

COPY package*.json ./
RUN yarn install

COPY . ./

RUN yarn run build

WORKDIR ${HOME}
