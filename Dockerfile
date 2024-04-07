FROM ruby:3.2.2-alpine

# 必要なパッケージをインストール
RUN apk add --no-cache build-base

# curlをインストール
RUN apk add --no-cache curl

# Yarnの公開鍵を直接ダウンロードしてインポート
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apk add --virtual .gnupg-deps gnupg && \
    apk del .gnupg-deps

# Yarnのリポジトリを追加
RUN apk add --no-cache yarn

# パッケージリストをアップデートしてからNode.jsをインストール
RUN apk add --no-cache nodejs

# 作業ディレクトリを設定
WORKDIR /app

# GemfileをコピーしてGemをインストール
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

# Precompile assets
RUN RAILS_ENV=production bundle exec rails assets:precompile

# コンテナの起動時のコマンドを設定
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
