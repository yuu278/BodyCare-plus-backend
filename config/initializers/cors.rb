# backend/config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins(
      'http://localhost:8000',
      'http://localhost:3000',
      /https:\/\/.*\.vercel\.app/
    )

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Authorization'],
      max_age: 600,
      credentials: true

    # WebSocket用の設定を追加
    resource '/ws',
      headers: :any,
      methods: [:get, :post],
      credentials: true
  end
end
