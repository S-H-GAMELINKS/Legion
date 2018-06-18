# Legion
## 概要
Ruby/Tk を使用して制作されたMastodonクライアントアプリっぽいものです。

## 使い方
`.env.sample` を `.env` にリネームし、必要な環境変数を記入していくだけです。

```
MASTODON_URL=<インスタンスのURL>
MASTODON_TOKEN=<インスタンスで発行したアクセストークン>
```

あとは、以下のコマンドでLegionのUIを起動させるだけです。

```
ruby legion.rb
```

基本的にMastodonインスタンスはLetsencryptを使用しているので、SSL証明書を使用する端末に導入しておく必要があります。
その点だけご注意ください

## 参考

[Ruby/Tk Beginner's tutorial ](https://www.dumbo.ai.kyutech.ac.jp/nomura-ken/kajiyama/ruby_tk/contents.html)

[mastodon-api](https://github.com/tootsuite/mastodon-api)
