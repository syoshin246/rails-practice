# ベースとして使用するイメージ名（DockerHubからダウンロードされる）
FROM ruby:3.2.2-alpine

ENV RAILS_ENV="production"
ENV NODE_ENV="production"

# 利用可能なパッケージのリストを更新するコマンドを実行
RUN apk update

# パッケージをインストールするコマンドを実行
RUN apk add g++ make mysql-dev tzdata

# コンテナを起動した時の作業ディレクトリを/appにする
WORKDIR /rails-practice

RUN apk add --no-cache -t .build-dependencies \
    build-base \
    libxml2-dev\
    libxslt-dev \
 && apk add --no-cache \
    bash \
    file \
    imagemagick \
    libpq \
    libxml2 \
    libxslt \
    nodejs \
    postgresql-dev \
    tini \
    tzdata \
    yarn \
 && gem install bundler:2.1.4 \
 && bundle install -j$(getconf _NPROCESSORS_ONLN) 
#  && bundle config set --localdeployment 'true'
#  && bundle config set --local
 && apk del --purge .build-dependencies

 # アプリケーションコードのコピー
COPY . /app

# アセットのプリコンパイル
RUN SECRET_KEY_BASE=placeholder bundle exec rails assets:precompile \
 && yarn cache clean \
 && rm -rf node_modules tmp/cache

# COPY start.sh /start.sh
# RUN chmod 744 /start.sh
# CMD ["sh", "/start.sh"]

ENV RAILS_SERVE_STATIC_FILES="true"
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
EXPOSE 3000