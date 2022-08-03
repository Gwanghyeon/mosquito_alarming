import json
import pandas as pd
import numpy as np

from flask import Flask, jsonify, request
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression


df = pd.read_csv('model/mosquito_table.csv')

# set mosquito alarming level to the target
x = df.loc[:, df.columns != 'level']
y = df.loc[:, df.columns == 'level']

# for training data with the size of 70%
x_train, x_test, y_train, y_test = train_test_split(
    x, y, test_size=0.3, random_state=5, stratify=y)

# fitting model
model = LogisticRegression()
model.fit(x_train, y_train.values.ravel())


app = Flask(__name__)


@app.route("/", methods=["GET", "POST"])
def predictLevel():
    global result

    if (request.method == "POST"):
        request_data = request.data
        request_data = json.loads(request_data.decode())

        temp = float(request_data['temp'])
        rainfall = float(request_data['rainFall'])
        data = np.array([temp, rainfall]).reshape(1, -1)
        result = int(model.predict(data)[0])
        return ""
    else:
        return jsonify({'result': result})


if __name__ == '__main__':
    app.run(debug=True)
