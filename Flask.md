Flask 环境安装
```bash
sudo apt-get update && \
sudo apt-get install -y pkg-config && \
sudo apt-get install -y libmysqlclient-dev && \
pip install flask Flask Flask-RESTful flask_sqlalchemy mysqlclient pymysql
```
```bash
pip install -r requirements.txt
```
<hr style="border: none; height: 1px; background-color: green;">
API 配置

```bash
from flask import Flask, request
from flask_restful import Resource, Api, reqparse
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from flask_cors import CORS  # 添加对CORS的支持
import secrets
import uuid
from fastapi import FastAPI


app = Flask(__name__)
app = FastAPI(docs_url="/docs")

CORS(app)  # 允许跨域请求
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:xinmima2018@47.236.73.192/api'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = secrets.token_hex(16)

db = SQLAlchemy(app)
api = Api(app)

parser = reqparse.RequestParser()
parser.add_argument('date_column', type=str, help='日期列是必需的')
parser.add_argument('username', type=str, help='用户名是必需的')
parser.add_argument('image_path', type=str, help='图片路径是必需的')

class FormData(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    uuid = db.Column(db.String(8), unique=True, nullable=False,
                     default=lambda: ''.join(c if c.isdigit() else str(ord(c) % 10) for c in str(uuid.uuid4())[:8]))
    date_column = db.Column(db.Date)
    image_path = db.Column(db.String(255))
    username = db.Column(db.String(50))
    submission_datetime = db.Column(db.DateTime, default=datetime.utcnow)

with app.app_context():
    db.create_all()

class FormDataResource(Resource):
    # 处理 GET 请求，获取表单数据
    def get(self, form_data_id=None):
        if form_data_id:
            # 获取特定 ID 的表单数据
            data = FormData.query.get(form_data_id)
            return self._get_single_data_response(data)
        else:
            # 获取所有表单数据
            form_data_list = FormData.query.all()
            return {'form_data': [self._serialize_data(data) for data in form_data_list]}

    # 处理 POST 请求，添加新的表单数据
    def post(self):
        try:
            args = parser.parse_args()
            new_data = FormData(
                date_column=args['date_column'],
                username=args['username'],
                image_path=args['image_path']
            )
            db.session.add(new_data)
            db.session.commit()
            return {'message': '表单数据成功添加', 'id': new_data.id}, 201
        except Exception as e:
            db.session.rollback()
            return {'message': '处理请求时发生错误'}, 500

    # 处理 PUT 请求，更新表单数据
    def put(self, form_data_id):
        data = FormData.query.get(form_data_id)
        if data:
            try:
                args = parser.parse_args()
                self._update_data(data, args)
                db.session.commit()
                return {'message': f'ID为 {form_data_id} 的表单数据已成功更新'}
            except Exception as e:
                db.session.rollback()
                return {'message': '处理请求时发生错误'}, 500
        else:
            return {'message': '未找到表单数据'}, 404

    # 处理 DELETE 请求，删除表单数据
    def delete(self, form_data_id):
        data = FormData.query.get(form_data_id)
        if data:
            try:
                # 删除关联的图片文件
                if data.image_path:
                    image_path = os.path.join(os.getcwd(), data.image_path)
                    if os.path.exists(image_path):
                        os.remove(image_path)
                        
                # 删除数据库中的数据        
                db.session.delete(data)
                db.session.commit()
                
                return {'message': f'ID为 {form_data_id} 的表单数据已成功删除'}
            except Exception as e:
                db.session.rollback()
                return {'message': '处理请求时发生错误'}, 500
        else:
            return {'message': '未找到表单数据'}, 404

    # 辅助方法：将数据序列化为 JSON 格式
    def _serialize_data(self, data):
        return {
            'id': data.id,
            'username': data.username,
            'image_path': data.image_path,
            'uuid': data.uuid,
            'date_column': data.date_column.strftime('%Y-%m-%d') if data.date_column else None,
        }

    # 辅助方法：获取单个数据的响应
    def _get_single_data_response(self, data):
        if data:
            return self._serialize_data(data)
        else:
            return {'message': '未找到表单数据'}, 404

    # 辅助方法：更新数据
    def _update_data(self, data, args):
        # 使用短路运算符确保只更新提供的非空值
        data.date_column = args['date_column'] or data.date_column
        data.username = args['username'] or data.username
        data.image_path = args['image_path'] or data.image_path

# 添加资源类到 API，并定义路由
api.add_resource(FormDataResource, '/form-data', '/form-data/<int:form_data_id>')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5100, debug=True)

```
<hr style="border: none; height: 1px; background-color: green;">
