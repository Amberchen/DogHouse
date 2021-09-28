from flaskext.mysql import MySQL
from mohouse import app
from flask import g


class DB:
    @staticmethod
    def connectDB():
        mysql = MySQL()
        app.config['MYSQL_DATABASE_USER'] = 'gatechUser'
        app.config['MYSQL_DATABASE_PASSWORD'] = 'gatech123'
        app.config['MYSQL_DATABASE_DB'] = 'cs6400_summer2020_team022'
        # app.config['MYSQL_DATABASE_PORT'] = 3308 # If you use MySQL docker, uncomment this line
        app.config['MYSQL_DATABASE_HOST'] = 'localhost'
        mysql.init_app(app)
        return mysql

    @staticmethod
    def getDB():
        if 'db' not in g:
            g.db = DB.connectDB()

        return g.db
