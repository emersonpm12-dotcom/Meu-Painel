# Meu Painel no GitHub Pages + Supabase

Com isso, voce e a Carol entram com e-mail e senha, lancam pelo mesmo link e veem as mudancas na hora. Nao precisa de conta no Claude.

Arquivos deste pacote:
- `index.html`, `manifest.webmanifest`, `icon.png`: o app. Estes 3 vao para o GitHub.
- `1-schema.sql`: cria a tabela e a seguranca no Supabase.
- `2-dados.sql`: seus dados atuais (286 registros). NAO suba para o GitHub, tem seus dados financeiros.

## 1. Supabase: banco de dados
1. Abra o seu projeto no Supabase (ou crie um novo, regiao South America (Sao Paulo)).
2. Menu **SQL Editor** > **New query**. Cole todo o `1-schema.sql` e toque em **Run**. Deve aparecer "Success".
3. Nova query: cole todo o `2-dados.sql` e **Run**. Isso traz seus lancamentos, metas, cartoes, tarefas e o historico de compras.
4. Confira em **Table Editor** > `docs`: devem existir 286 linhas.

## 2. Supabase: as duas contas de acesso
1. Menu **Authentication** > **Users** > **Add user** > **Create new user**.
2. Crie uma conta com o seu e-mail e uma senha forte, marcando **Auto Confirm User**. Repita para a Carol.
3. Feche o cadastro aberto: em **Authentication** > **Sign In / Providers** (ou Settings), desligue **Allow new users to sign up**. Assim so as 2 contas entram.

## 3. Pegar a URL e a chave publica
1. **Project Settings** > **API** (ou **Data API / API Keys**).
2. Copie a **Project URL** (algo como `https://xxxx.supabase.co`).
3. Copie a chave **anon public** (tambem chamada de publishable). Essa chave e feita para ficar no app e e protegida pelo login.
4. NUNCA use nem compartilhe a chave **service_role**.

## 4. Colocar a URL e a chave no app
No `index.html`, perto do fim, ache estas duas linhas e troque pelo que voce copiou (mantenha as aspas):
```
const SUPABASE_URL='COLE_AQUI_A_URL_DO_PROJETO';
const SUPABASE_KEY='COLE_AQUI_A_CHAVE_ANON_PUBLICA';
```
Dica: se voce me mandar a URL e a chave anon, eu devolvo o arquivo ja preenchido.

## 5. GitHub Pages
1. No GitHub, **New repository**, nome `meu-painel`, marque **Public** (no plano gratuito o Pages exige repositorio publico).
2. **Add file** > **Upload files** e envie so: `index.html`, `manifest.webmanifest` e `icon.png`. **Commit changes**.
3. **Settings** > **Pages** > em Source escolha **Deploy from a branch**, branch `main`, pasta `/ (root)` > **Save**.
4. Em 1 a 2 minutos o endereco aparece: `https://SEU-USUARIO.github.io/meu-painel/`.

O repositorio e publico, mas ninguem ve seus dados: eles ficam no Supabase, atras do login.

## 6. Usar no iPhone
1. Abra o endereco no **Safari** e entre com o e-mail e a senha.
2. Escolha **Emerson** ou **Carol** em "Quem e voce?".
3. **Compartilhar** > **Adicionar a Tela de Inicio**. Faca o mesmo no iPhone da Carol com a conta dela.

## Se algo der errado
- "E-mail ou senha incorretos": confira se o usuario foi criado com **Auto Confirm User**.
- Tela em branco ou "Falta configurar": a URL e a chave nao foram coladas no `index.html`.
- "Erro ao ler os dados" ou lista vazia: rode de novo o `1-schema.sql` e confira se o `2-dados.sql` rodou.
- O que um lanca nao aparece no outro na hora: no Supabase, **Database** > **Replication**, confira se a tabela `docs` esta ligada em `supabase_realtime`.
- Mudou algo no GitHub e o app nao atualizou: feche o app e abra de novo, ou espere 1 a 2 minutos.
