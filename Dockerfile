FROM ruby:3.1-alpine

ARG SHOPIFY_API_KEY
ARG SHOPIFY_API_SECRET

ENV SHOPIFY_API_KEY=$SHOPIFY_API_KEY
ENV SHOPIFY_API_SECRET=$SHOPIFY_API_SECRET
ENV HOST="https://shopify-app.stack360.co"
ENV SCOPES="write_products, read_themes, write_themes"

# Install packages needed to build pg gem and node modules
RUN apk update && apk add nodejs npm git build-base sqlite-dev gcompat bash openssl-dev libpq-dev postgresql-client

WORKDIR /app

COPY web .

RUN cd frontend && npm install
RUN bundle install

RUN cd frontend && npm run build
RUN rake build:all

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
