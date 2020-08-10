# encoding: utf-8
"""
@author : shirukai
@date : 2020/8/10
程序入口
"""

from flask import Flask

# create a flask app
app = Flask(__name__)


@app.route("/")
def index():
    return "Hello world !"


if __name__ == '__main__':
    # run server
    app.run(host="0.0.0.0", port=5000)
