# Rollingup
Rollingup is a Dungeon and Dragons character sheet creation assistant app that allows a user to create and update any number of DnD characters.
The app is build with Vue.js around a Ruby on Rails + PostgreSQL api

## Installation
<p>
  <!-- version -->
  <img src='https://badgen.net/badge/Ruby/v3.2.2/red' />
  <img src='https://badgen.net/badge/Rails/v7.0.4.2/red' />
  <img src='https://badgen.net/badge/Vue.js/v3.3.2/green' />
  <img src='https://badgen.net/badge/Typescript/v5.0.2/blue' />
  <img src='https://badgen.net/badge/Vite/v4.3.2/purple' />
</p>

```
git clone git@github.com:wJoenn/rolling-up.git
cd rolling-up
```
Delete the `api/config/credentials.yml.enc` file
```
rails secret # Copy the secret key somewhere
EDITOR="code --wait" rails credentials:edit
```
Add a new key called devise_jwt_secret_key and copy the secret key you generated then save and exit
```
setup
dev
```
