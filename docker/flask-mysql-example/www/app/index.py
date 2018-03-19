#!/usr/bin/env python
import os
from flask import Flask, abort, request, jsonify, g, url_for
from flask_sqlalchemy import SQLAlchemy
from flask_httpauth import HTTPBasicAuth
from passlib.apps import custom_app_context as pwd_context
from itsdangerous import (TimedJSONWebSignatureSerializer
                          as Serializer, BadSignature, SignatureExpired)

app = Flask(__name__)

# Configure MySQL connection.
db = SQLAlchemy()
db_uri = 'mysql://root:insertsecurepass@db/users'
app.config['SECRET_KEY'] = 'some very secret app key'
app.config['SQLALCHEMY_DATABASE_URI'] = db_uri
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)

# extensions
db = SQLAlchemy(app)

class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(32), index=True)
    password_hash = db.Column(db.String(512))

@app.route("/")
    result = False
    if db.session.query("1").from_statement("SELECT 1").all():
	result = True
    if result:
        res = Markup('<span style="color: green;">PASSED</span>')
    else:
        res = Markup('<span style="color: red;">FAILED</span>')

if __name__ == '__main__':
    db.create_all()
    app.run(host="0.0.0.0", port=5000)
