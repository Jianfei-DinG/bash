路由呈现数据
```
from flask import jsonify

@app.route('/')
def index():
    # 查询数据库获取数据
    results = Resultding.query.all()

    # 将数据转换为字典列表
    data = [{"id": result.id, "result_name": result.result_name, "decimal_number": result.decimal_number} for result in results]

    # 使用 jsonify 函数将字典列表转换为 JSON 格式
    return jsonify(data)
```

```
// 使用 AJAX 请求数据
$.ajax({
    url: "/",
    type: "GET",
    success: function(data) {
        // 在这里处理从服务器获取到的 JSON 数据
        console.log(data);
    },
    error: function(error) {
        console.log(error);
    }
});

```
<hr>
