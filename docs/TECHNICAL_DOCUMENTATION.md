# Documentação Técnica - Blog

## 📋 Sumário Executivo

Este documento fornece uma visão geral das tecnologias, arquitetura e dependências utilizadas no projeto Blog. Trata-se de uma aplicação Rails moderna, desenvolvida como uma plataforma de gerenciamento de posts com arquitetura escalável e preparada para containerização.

---

## 🛠️ Stack Tecnológico

### Linguagem & Framework Principal
- **Ruby**: 3.2.2
- **Rails**: 8.1.1 (latest stable)

### Servidor Web & Runtime
- **Puma**: Web server HTTP (≥5.0)
- **Thruster**: Middleware para cache HTTP e compressão de assets em produção
- **Bootsnap**: Otimização de tempo de boot através de caching

### Banco de Dados
- **SQLite3**: ≥2.1
  - Desenvolvimento: `storage/development.sqlite3`
  - Testes: `storage/test.sqlite3`
  - Produção: `storage/production.sqlite3` (volume persistente Docker)

### Frontend & JavaScript
- **Hotwire Stack**:
  - **Turbo Rails**: Acelerador SPA-like para navegação rápida
  - **Stimulus Rails**: Framework JavaScript modesto e reativo
- **Importmap Rails**: Gerenciador de dependências ES modules sem build step
- **Propshaft**: Asset pipeline moderno para Rails 8

### Banco de Dados Alternativos
- **Solid Cache**: Adapter de cache baseado em banco de dados
- **Solid Queue**: Gerenciador de filas de tarefas (Active Job)
- **Solid Cable**: Adapter de WebSocket para Action Cable

---

## 🏗️ Arquitetura

### Padrão MVC (Model-View-Controller)

#### Models
- **Post**: Modelo principal do domínio
  - Validações: `title`, `text`, `user`, `theme` (obrigatórios)
  - Inherita de `ApplicationRecord`

#### Controllers
- **PostsController**: Controlador RESTful para gerenciar posts
- **ApplicationController**: Controlador base

#### Views
- Layout base: `layouts/application.html.erb`
- Views específicas:
  - `posts/index.html.erb` - Listagem de posts
  - `posts/show.html.erb` - Detalhes do post
  - `posts/new.html.erb` - Formulário de criação
  - `posts/edit.html.erb` - Formulário de edição

#### Assets
- **Stylesheets**: CSS global em `app/assets/stylesheets/application.css`
- **JavaScript**: Controllers Stimulus em `app/javascript/controllers/`

### Recursos & Engine
- **Action Cable**: WebSocket via SolidCable
- **Active Job**: Processamento de jobs assíncronos via SolidQueue
- **ActionMailer**: Sistema de e-mails

### API & Documentação
- **Rswag**: Geração e visualização de documentação OpenAPI/Swagger
  - Monta em `/api-docs` - UI interativa
  - Suporta especificação Swagger/OpenAPI

---

## 📦 Dependências Principais

### Gems de Produção

#### Web & Routing
```ruby
rails ~> 8.1.1      # Framework web full-stack
puma >= 5.0         # Web server
rack-cors           # CORS middleware
```

#### Storage & Assets
```ruby
propshaft           # Asset pipeline moderno
image_processing    # Processamento de imagens
```

#### Persistência de Dados
```ruby
sqlite3 >= 2.1      # Database
solid_cache         # Cache em DB
solid_queue         # Job queue em DB
solid_cable         # WebSocket em DB
```

#### Frontend
```ruby
importmap-rails     # ES module imports
turbo-rails         # Navegação SPA
stimulus-rails      # Framework JS
jbuilder            # JSON API builder
```

#### Deployment
```ruby
kamal               # Deploy Docker orquestrado
thruster            # HTTP cache e compressão
```

#### Utilitários
```ruby
tzinfo-data         # Time zone data
bootsnap            # Boot time caching
```

### Gems de Desenvolvimento

#### Debugging & Console
```ruby
debug               # Debugger integrado
web-console         # Console nas páginas de erro
```

#### Documentação API
```ruby
rswag-api           # OpenAPI/Swagger API
rswag-ui            # UI para documentação
```

#### Linting & Code Quality
```ruby
rubocop-rails-omakase  # Style guide Omakase para Rails
```

#### Segurança
```ruby
brakeman            # Security vulnerabilities scanner
bundler-audit       # Gem security audit
```

### Gems de Testes

```ruby
capybara            # Browser automation para system tests
selenium-webdriver  # WebDriver para testes
```

---

## 🔌 Integrações Externas

### CORS (Cross-Origin Resource Sharing)
- Configurado para aceitar requisições de `http://localhost:5173`
- Métodos permitidos: GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD
- Headers: Qualquer header é aceito

### Email
- ActionMailer configurado via `app/mailers/`
- Mailers base: `application_mailer.rb`

---

## 🐳 Infraestrutura & Deployment

### Docker
- **Ruby Base Image**: `ruby:3.4.8-slim`
- **Arquitetura Multi-stage**:
  1. Base stage: Setup de ambiente
  2. Build stage: Compilação de gems e assets
  3. Final stage: Aplicação otimizada para produção

### Otimizações Docker
- **Jemalloc**: Memory allocator para reduzir uso de memória
- **Bootsnap precompile**: Pré-compilação de bytecode
- **Asset precompilation**: Assets compilados em build time
- **Non-root user**: Executa como usuário `rails` (UID 1000)

### Kamal
- Deployment orchestration para Docker
- Configurado em `config/deploy.yml`

### Variáveis de Ambiente
- `RAILS_ENV`: production (em Docker)
- `RAILS_MASTER_KEY`: Required para credentials
- `RAILS_MAX_THREADS`: Configurável (padrão: 5)
- `WEB_CONCURRENCY`: Número de workers Puma

---

## 🗄️ Estrutura de Banco de Dados

### Migrações
- `20251222213509_create_posts.rb` - Criação da tabela posts
- `20260106221028_remove_date_from_posts.rb` - Remoção de coluna date

### Schemas Especializados
- `db/schema.rb` - Schema principal
- `db/cache_schema.rb` - Schema do SolidCache
- `db/queue_schema.rb` - Schema do SolidQueue
- `db/cable_schema.rb` - Schema do SolidCable

---

## 🛣️ Rotas & Endpoints

### RESTful Resources
```ruby
resources :posts
```

Endpoints disponíveis:
- `GET /posts` - Listagem
- `GET /posts/new` - Formulário novo
- `POST /posts` - Criar
- `GET /posts/:id` - Visualizar
- `GET /posts/:id/edit` - Formulário edição
- `PATCH/PUT /posts/:id` - Atualizar
- `DELETE /posts/:id` - Deletar

### API Documentation
- `GET /api-docs` - Swagger UI
- `GET /api-docs/v1/swagger.yaml` - OpenAPI spec

---

## 📁 Estrutura de Diretórios

```
blog/
├── app/
│   ├── assets/              # Stylesheets e imagens
│   ├── controllers/         # Controllers REST
│   ├── helpers/             # View helpers
│   ├── javascript/          # Stimulus controllers
│   ├── models/              # Modelos (Post, etc)
│   ├── views/               # Templates ERB
│   └── jobs/                # Background jobs
├── config/
│   ├── initializers/        # Setup (CORS, CSP, etc)
│   ├── environments/        # Config por ambiente
│   ├── database.yml         # Banco de dados
│   ├── routes.rb            # Rotas
│   └── puma.rb              # Configuração Puma
├── db/
│   ├── migrate/             # Migrações
│   └── seeds.rb             # Seeds
├── test/                    # Testes (unit e system)
├── public/                  # Arquivos estáticos
├── storage/                 # Banco local de desenvolvimento
├── Dockerfile               # Containerização
├── Gemfile                  # Dependências Ruby
└── config.ru                # Entry point Rack
```

---

## 🧪 Testes

### Tipo de Testes Configurados
- **Unit Tests**: Models via `test/models/`
- **Controller Tests**: `test/controllers/`
- **System Tests**: E2E com Capybara e Selenium
- **Fixtures**: Dados de teste em `test/fixtures/`

### Executar Testes
```bash
./bin/rails test               # Todos os testes
./bin/rails test:system        # System tests apenas
```

---

## 🔒 Segurança

### Implementado
- **CORS**: Restricção a origem específica
- **Brakeman**: Scanning de vulnerabilidades estáticas
- **Bundler Audit**: Auditoria de gems comprometidas
- **CSP**: Content Security Policy em `config/initializers/`
- **Credentials**: Via `config/credentials.yml.enc`

### Boas Práticas
- Docker com usuário non-root
- RAILS_MASTER_KEY para decriptação
- Parameter filtering para logs sensíveis

---

## 🚀 Desenvolvimento Local

### Requisitos
- Ruby 3.2.2 (via mise)
- Bundler

### Setup
```bash
bundle install
./bin/rails db:create
./bin/rails db:migrate
./bin/rails server
```

### Dev Tools Disponíveis
```bash
./bin/dev            # Parallel execution
./bin/rails          # Rails CLI
./bin/rake           # Task runner
./bin/rubocop        # Linting
./bin/brakeman       # Security scan
./bin/bundler-audit  # Dependency audit
```

---

## 📊 Performance & Caching

### Estratégias
- **Bootsnap**: Pré-compilação de Ruby bytecode
- **SolidCache**: Cache com fallback em banco
- **Thruster**: HTTP caching headers e compressão
- **Puma Threading**: Thread pool configurável (padrão: 3 threads)

### Monitoramento
- Logs em `log/` (development/production)
- Pids em `tmp/pids/`
- Cache bootsnap em `tmp/cache/`

---

## 🔄 Fluxos de Integração

### CORS (Acesso Frontend)
Frontend rodando em `http://localhost:5173` pode fazer requisições a este servidor.

### Pipeline de Assets
```
app/javascript/
  ↓
Importmap (ES modules)
  ↓
Prefetch & Inline (Propshaft)
  ↓
Served via Thruster
```

### Banco de Dados
```
Rails ORM (AR)
  ↓
SQLite3 Adapter
  ↓
Arquivo SQLite (storage/)
```

---

## 📝 Configurações de Ambiente

### Development
- SQLite local
- Reloading automático
- Web console ativo
- CORS para localhost:5173

### Production
- SQLite em volume Docker persistente
- Assets pré-compilados
- Credentials encriptadas
- Thruster para otimização
- Jemalloc para memory efficiency

### Test
- SQLite isolado
- Fixtures carregadas
- Capybara + Selenium para E2E

---

## 📚 Recursos Adicionais

### Documentação Oficial
- Rails 8.1: https://guides.rubyonrails.org/
- Hotwire: https://hotwired.dev/
- Kamal: https://kamal-deploy.org/
- Rswag: https://github.com/rswag/rswag

### Archivos de Configuração
- `.ruby-version`: Especifica Ruby 3.2.2
- `config/deploy.yml`: Configuração Kamal
- `config/bundler-audit.yml`: Whitelist de vulnerabilidades
- `Rakefile`: Tasks customizadas

---

## ✅ Checklist de Dependências Críticas

- ✅ Rails 8.1.1 (stable)
- ✅ Ruby 3.2.2
- ✅ Puma 5+ (production server)
- ✅ SQLite3 2.1+ (persistence)
- ✅ Hotwire (modern UX)
- ✅ Docker (containerization)
- ✅ Security scanners (brakeman, bundler-audit)
- ✅ API documentation (Rswag/Swagger)


