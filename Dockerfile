FROM directus/directus:latest

USER root
RUN mkdir -p /directus/extensions && chown -R node:node /directus/extensions

COPY --chown=node:node ./extensions /directus/extensions

USER node

WORKDIR /directus

EXPOSE 8055