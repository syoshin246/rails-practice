FROM ruby:3.2.2-alpine

# curlをインストール
RUN apk add --no-cache curl

# curlを使ってYarnのGPGキーを取得し、インポート
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --import -

# Yarnのリポジトリを追加
RUN apk add --no-cache yarn

# パッケージリストをアップデートしてからNode.jsとYarnをインストール
RUN apk add --no-cache nodejs

# 作業ディレクトリを設定
WORKDIR /app

# GemfileをコピーしてGemをインストール
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

# コンテナの起動時のコマンドを設定
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
