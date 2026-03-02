# Blog

Aplicação Ruby on Rails simples para gerenciamento de posts, construída com
Rails 8 e Hotwire. O projeto é compatível com container e inclui interface de
documentação de API via Swagger.

## 🚀 Tecnologias principais

- Ruby 3.2.2
- Rails 8.1.1
- Hotwire (Turbo + Stimulus)
- SQLite3 (padrão para desenvolvimento/teste/produção)
- Servidor web Puma
- Docker (builds multi-stage + Kamal)
- Rswag para documentação da API

## 🛠️ Pré-requisitos

- Ruby 3.2.2 (especificado em `.ruby-version` / `mise.toml`)
- Bundler
- SQLite3 (dev/test, já incluso na base Docker)
- Docker e Kamal (para deploy em contêiner)

## ⚙️ Configuração do ambiente

```bash
# instale as gems
bundle install

# crie e migre o banco de dados
bin/rails db:create db:migrate

# opcional: carregue dados de seed
bin/rails db:seed
```

### Rodando em desenvolvimento

```bash
bin/rails server               # http://localhost:3000
```

## 📁 Estrutura resumida

- `app/` → código MVC (models, controllers, views)
- `config/` → rotas, inicializadores, ambiente
- `db/` → migrações e esquemas

## 🔧 Observações

- CORS habilitado para `http://localhost:5173` (frontend separado)
- Documentação da API disponível em `/api-docs` (ex: http://localhost:3000/api-docs)
- Dependências de desenvolvimento incluem Brakeman, Bundler Audit e
  RuboCop para análise estática
