FROM node:24-alpine

WORKDIR /app

COPY . .

RUN npm install -g directus

# Instala dependências de extensões, se existir package.json
RUN if [ -f package.json ]; then npm install; fi

RUN mkdir -p /app/uploads /app/database

EXPOSE 8055

CMD ["directus", "start"]