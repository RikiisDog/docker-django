# docker-django-nginx-uwsgi-postgresql

### ローカル環境
- Windows 10 Home 22H2
- Docker Desktop 4.18.0
- Visual Studio Code 1.77.3
- git 2.39.1
- DBeaver23.0.3(必要に応じて)

### 構築する環境
- Python 3.10
- Django 4.1
- uwsgi 2.0.20
- PostgreSQL 15
- nginx 1.20

### 構築後のディレクトリ構成
```
docker-django
├ docker
│ ├ app
│ │ ├ Dockerfile
│ │ ├ requirements.txt
│ │ └ uwsgi.ini
│ ├ db
│ │ ├ sql
│ │ │ └ init_db.sh
│ │ └ db-access.env
│ └ nginx
│ 　 ├ Dockerfile
│ 　 ├ nginx.conf
│ 　 └ uwsgi_params
├ src
│ ├ myproject
│ │ ├ __pycashe__
│ │ ├ __init__.py
│ │ ├ asgi.py
│ │ ├ settings.py
│ │ ├ urls.py
│ │ └ wsgi.py
│ ├ static
│ ├ manage.py
│ ├ uwsgi.ini
│ ├ uwsgi.pid
│ └ uwsgi.sock
└ docker-compose.yml
```

### 1.リポジトリをクローン
```
$ git clone https://github.com/RikiisDog/docker-django.git
```

### 2.イメージのビルド
```
$ docker-compose build
```

### 3.Djangoプロジェクト作成
```
$ docker-compose --rm run app django-admin startproject myproject .
```

### 4.settings.pyを編集
下記を任意の場所に追加
```
import os

STATIC_ROOT = os.path.join(BASE_DIR, 'static/')

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'django_db',
        'USER': 'django',
        'PASSWORD': 'django',
        'HOST': 'db',
        'PORT': '5432'
        }
}
```

### 5.静的ファイルを集約する
```
$ docker-compose run --rm app ./manage.py collectstatic
```

### 6.コンテナ起動
```
$ docker-compose up
```

### 7.動作確認
http://localhost:8000/ へアクセスし、いつものDjangoの初期画面にアクセスできれば成功です。
あとはここからお好きに開発を進めてください。