from flask import Flask, url_for, flash, redirect, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql import select

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI']= 'sqlite:///site.db'
db = SQLAlchemy(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key= True)
    username = db.Column(db.String(20), unique= True, nullable= False)
    
    def __repr__(self):
        return "User('%s','%s')" % (self.id, self.username)

    def  __init__(self,id ,username):
        self.id = id
        self.username = username 

@app.route("/set_new_user",methods=['POST'])
def set_user():
    new_id = request.form['id']
    new_username = request.form['username']
    new_user = User(new_id,new_username)
    db.session.add(new_user)
    db.session.commit()
    return


@app.route("/del",methods=['POST'])
def del_user():
    db.session.query(User).delete()
    db.session.commit()
    return
    
@app.route("/")
def hello():
    return "Hello World!"

@app.route("/get_users", methods=['GET'])
def get_users():
    return str(User.query.all())

if __name__ == '__main__':
    app.run(debug=TRUE)


