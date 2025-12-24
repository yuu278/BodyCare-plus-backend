# BodyCare+ Backend API

BodyCare+ アプリの **本番用バックエンド API** です。
フロントエンド（Vercel）からのリクエストを受け取り、認証・診断データ管理・ストレッチ推薦を提供します。

## デプロイ構成
- フロントエンド：Vercel
- バックエンド：Heroku（本リポジトリ）

## 技術スタック
- Ruby on Rails（APIモード）
- MySQL
- JWT 認証
- Cloudinary（動画管理）

## 主な機能
- JWT によるユーザー認証
- 身体状態診断データの保存
- 診断結果に基づくストレッチ推薦 API

## セットアップ（ローカル）
```bash
bundle install
rails db:create db:migrate db:seed
rails server
