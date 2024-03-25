#!/bin\sh

if[ "${RAILS_ENV}" = "prodction" ]
then
# 本番に必要な処理
    bundle exec rails assets:precompile
fi
# Railsサーバーを立ち上げる
bundle exec rails s -p ${PORT:-3000} -b 0.0.0.0