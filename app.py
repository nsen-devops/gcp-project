from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello Nitin Sen, How are you feeling today :D ?'
