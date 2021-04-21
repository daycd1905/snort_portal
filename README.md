# snort_portal

## Update MD lan 4
# Pull code truoc sau do run cmd
```bash
bundle install
```

## Update MD lan 3
# Pull code truoc sau do chay cmd
```bash
bundle install
rake db:migrate
```


## Update MD lan 2
# Run CMD nay truoc khi pull code
```bash
rake db:migrate:down VERSION=20210205133631
```
Sau do pull code
# Run CMD
```bash
rake db:migrate
```

## Cài trước postgreql

## Installing Ruby

To make sure we have everything necessary for Webpacker support in Rails, we're first going to start by adding the Node.js and Yarn repositories to our system before installing them.

```bash
sudo apt install curl
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update
sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn
```

Using `rvm` to install ruby
```bash
sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable source ~/.rvm/scripts/rvm
rvm install 3.0.0
rvm use 3.0.0 --default
ruby -v
```

The last step is to install Bundler
```bash
gem install bundler
```

## Installing Rails
# BẮT BUỘC PHẢI CÀI ĐÚNG VERSION DƯỚI ĐÂY:
```bash
gem install rails -v 6.0.3.4
```

Run command to check version:
```bash
rails -v
```


# Set up Enviroment variables
```bash
DB_HOST= <ip postgresql>
DB_PORT= <port postgresql>
DB_NAME= <database name>
DB_USERNAME= <database username>
DB_PASSWORD= <database password>
SNORT_API_ENDPOINT= <ip snort api>
```


# Run app
## Migrate database
```bash
rake db:create
rake db:migrate
```

## Install library
```bash
bundle install
```



## Run app
```bash
rails s
```
