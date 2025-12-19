# Backend API

BodyCare+ アプリのバックエンドAPIです。身体状態の診断保存や、診断に基づいたストレッチ推奨APIを提供します。

Rails API + MySQL + JWT認証

## セットアップ
```bash
bundle install
rails db:create db:migrate db:seed
rails server -p 3001
```

## APIエンドポイント

- `POST /api/v1/auth/login` - ログイン
- `POST /api/v1/body_assessments` - 診断保存
- `GET /api/v1/user_stretches/recommended` - おすすめ取得
