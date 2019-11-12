import cv2
from PIL import ImageFont, ImageDraw, Image
import numpy as np

fontpath = 'font/simsun.ttc'               # 字体路径
font = ImageFont.truetype(fontpath, 32)    # 字体大小为32


img_orig = [['1a.png','(a)A类序列在随机接入配置下的RD曲线'],
        ['1b.png','(b)B类序列在随机接入配置下的RD曲线'],
        ['1c.png','(c)C类序列在随机接入配置下的RD曲线'],
        ['1d.png','(d)D类序列在随机接入配置下的RD曲线'],
        ['1e.png','(e)E类序列在随机接入配置下的RD曲线'],
        ['2a.png','(a)A类序列在低时延配置下的RD曲线'],
        ['2b.png','(b)B类序列在低时延配置下的RD曲线'],
        ['2c.png','(c)C类序列在低时延配置下的RD曲线'],
        ['2d.png','(d)D类序列在低时延配置下的RD曲线'],
        ['2e.png','(e)E类序列在低时延配置下的RD曲线']]
print(img_orig)
for png_lable in img_orig:
    png = png_lable[0]
    lable = png_lable[1]
    img=cv2.imread(png)
    # 扩张边缘
    constant=cv2.copyMakeBorder(img,0,40,0,0,cv2_BORDER_CONSTANT, value=[255,255,255])
    cv2.imwrite('a_'+png, constant)
    # 添加文字
    img_pil = Image.fromarray(constant)
    draw = ImageDraw.Draw(img_pil)
    # 位置(100, 300), 颜色(0,0,0), 字内容lable
    draw.text((100,300), lable, font=font, fill = (0,0,0,0))
    bk_img = np.array(img_pil)
    # 写入
    cv2.imwrite('a_'+png, bk_img)




