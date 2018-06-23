# Legion
## 概要
Ruby/Tk を使用して制作されたMastodonクライアントアプリっぽいものです。

## 使い方

以下のコマンドでLegionをインストールします。

```
gem install legion_mastodon_client
```

そして、以下のファイルを作成します。

```ruby:legion.rb
require 'bundler/setup'
Bundler.require(:default)

require 'legion'

Legion.exec
```

```ruby:Gemfile
source "https://rubygems.org"

gem 'legion_mastodon_client', '~> 0.1.0'
gem 'mastodon-api', git: 'https://github.com/tootsuite/mastodon-api.git', ref: '189deb8'
gem 'dotenv'
gem "highline"
gem 'nokogiri'
gem 'rmagick'
gem 'parallel'
```

その後、bundle install でgemをインストール

```
bundle install
```

後は、`.env` を作成し、必要な環境変数を記入していくだけです。

```:.env
MASTODON_URL=<インスタンスのURL>
MASTODON_TOKEN=<インスタンスで発行したアクセストークン>
```

最後に以下のコマンドでLegionのUIを起動させるだけです。

```
ruby legion.rb
```

基本的にMastodonインスタンスはLetsencryptを使用しているので、SSL証明書を使用する端末に導入しておく必要があります。
その点だけご注意ください

## 参考

[Ruby/Tk Beginner's tutorial ](https://www.dumbo.ai.kyutech.ac.jp/nomura-ken/kajiyama/ruby_tk/contents.html)

[mastodon-api](https://github.com/tootsuite/mastodon-api)
