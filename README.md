# Esqueleto para Aplicação Web

### HTML 5 + CSS 3 + Javascript

Este repositório é o esqueleto de uma aplicação que utiliza a [Iugu-UX](http://github.com/iugu/iugu-ux) e algumas funcionalidades de Sprockets e Ruby para compilar e gerar automaticamente todos os requisitos necessários para a construção de uma aplicação moderna e robusta.

### Executando

Faça uma cópia do repositório e utilize ```bundle install``` para instalar todas as dependências.

```make start``` => Inicializa o Esqueleto em Modo de Desenvolvimento. O serviço fica disponível no endereço: ```http://localhost:3000```

```make package``` => Compila a aplicação e todas as suas dependências para o diretório *build*

### Configurações

**config.yml**

Nas configurações você deve colocar todas as necessidades de arquivos de sua aplicação. Recomendamos manter a quantidade de conteúdo baixo e utilizar declarações @import para agrupar os arquivos. Quando inserido um nome de diretório, o mesmo será copiado para a pasta final da aplicação.

```
content: **( arquivos e diretórios a serem inclusos no pacote final )**  
  - "application.css"  
  - "statics"

network: **( endereços e rotas padrões a serem inclusos no pacote final )**  
  - '/'  
  - '/manifest.appcache'  

remove_old_files: true **( remover arquivos antigos )**
```

#### Configurar src/templates/index.rhtml

Este arquivo é a raiz de sua aplicação. É recomendado editar e modificar a seu critério.

#### Novas Rotas e Views estáticas

Em geral, seu aplicativo é composto de apenas uma página física no servidor, mas há casos em que é necessário criar outros tipos de arquivos ou configurações. Neste caso é necessário editar o arquivo ```webapp.rb``` e fazer as devidas modificações.

### Estrutura de Diretório

```text
src/css:
Arquivos CSS. Suporte à SASS

src/js:
Aplicação. Consultar documentação da Iugu-UX

src/statics:
Arquivos Estáticos
```

#### Consulte a Documentação da [Iugu-UX](http://github.com/iugu/iugu-ux)
