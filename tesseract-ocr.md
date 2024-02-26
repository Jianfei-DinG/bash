Tesseract-OCR
```
from flask import Flask, render_template, request, redirect
from PIL import Image, ImageEnhance
import pytesseract
import cv2
import os

app = Flask(__name__)

# 创建上传目录
UPLOAD_FOLDER = 'uploads'
CROPPED_FOLDER = 'cropped'
PREPROCESSED_FOLDER = 'preprocessed'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['CROPPED_FOLDER'] = CROPPED_FOLDER
app.config['PREPROCESSED_FOLDER'] = PREPROCESSED_FOLDER

# 图像预处理
def preprocess_image(image_path):
    image = Image.open(image_path)

    # 增强对比度
    enhancer = ImageEnhance.Contrast(image)
    image = enhancer.enhance(1.2)

    # 进行形态学操作（腐蚀和膨胀）
    kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (2, 1))  # 数值越大小文字就会有残缺
    img_array = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)
    img_array = cv2.threshold(img_array, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)[1] # 把图片做成黑白色
    img_array = cv2.morphologyEx(img_array, cv2.MORPH_CLOSE, kernel)

    return Image.fromarray(img_array)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload():
    if 'file' not in request.files:
        return redirect(request.url)

    file = request.files['file']

    if file.filename == '':
        return redirect(request.url)

    if file:
        # 保存上传的图像
        image_path = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
        file.save(image_path)

        # 裁剪上部分
        height, width, _ = cv2.imread(image_path).shape
        cropped_image = cv2.imread(image_path)[0:int(height//2.8), 0:int(width)]

        # 创建 uploads/cropped 目录，如果不存在
        cropped_folder_path = os.path.join(app.config['UPLOAD_FOLDER'], app.config['CROPPED_FOLDER'])
        os.makedirs(cropped_folder_path, exist_ok=True)

        # 保存裁剪后的图片
        cropped_image_path = os.path.join(cropped_folder_path, 'cropped_' + file.filename)
        cv2.imwrite(cropped_image_path, cropped_image)

        # 图像预处理
        preprocessed_image = preprocess_image(cropped_image_path)

        # 创建 uploads/preprocessed 目录，如果不存在
        preprocessed_folder_path = os.path.join(app.config['UPLOAD_FOLDER'], app.config['PREPROCESSED_FOLDER'])
        os.makedirs(preprocessed_folder_path, exist_ok=True)

        # 保存预处理后的图片
        preprocessed_image_path = os.path.join(preprocessed_folder_path, 'preprocessed_' + file.filename)
        preprocessed_image.save(preprocessed_image_path)

        # 调整 Tesseract 参数
        custom_config = r'--psm 6 --oem 1 --dpi 600'

        # 执行图像文字提取
        extracted_text = pytesseract.image_to_string(preprocessed_image, lang='chi_sim', config='--psm 6 --oem 1 --dpi 600')

        return render_template('result.html', text=extracted_text)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5600, debug=True)

```
