# ベースとして使用するイメージ名（DockerHubからダウンロードされる）
FROM ruby:3.2.2-alpine

ENV RAILS_ENV="production"
# ENV NODE_ENV="production"

# 利用可能なパッケージのリストを更新するコマンドを実行
RUN apk update

# パッケージをインストールするコマンドを実行
RUN apk add g++ make mysql-dev tzdata

# コンテナを起動した時の作業ディレクトリを/appにする
WORKDIR /rails-practice

# PC上のGemfile を .（/app）にコピー
COPY Gemfile .
COPY Gemfile.lock .

# bundle installでGemfileに記述されているgemをインストール
RUN bundle install

COPY start.sh /start.sh
RUN chmod 744 /start.sh
CMD ["sh", "/start.sh"]

# ENV RAILS_SERVE_STATIC_FILES="true"
# ENTRYPOINT ["/sbin/tini", "--"]
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
# EXPOSE 3000