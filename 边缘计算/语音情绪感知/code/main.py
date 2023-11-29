import SparkApi
import serial
from playsound import playsound
import websocket
import datetime
import hashlib
import base64
import hmac
import json
from urllib.parse import urlencode
import time
import ssl
from wsgiref.handlers import format_date_time
from datetime import datetime
from time import mktime
import _thread as thread
import os

#以下密钥信息从控制台获取，出于保密考虑，下面的所有API都已隐去，如有问题请联系作者
appid = "*****"     #填写控制台中获取的 APPID 信息
api_secret = "*******"   #填写控制台中获取的 APISecret 信息
api_key ="*******"    #填写控制台中获取的 APIKey 信息

#用于配置大模型版本，默认“general/generalv2”
domain = "general"   # v1.5版本
# domain = "generalv2"    # v2.0版本
#云端环境的服务地址
Spark_url = "ws://spark-api.xf-yun.com/v1.1/chat"  # v1.5环境的地址
# Spark_url = "ws://spark-api.xf-yun.com/v2.1/chat"  # v2.0环境的地址

#串口通信设置
serialPort = "COM10"
baudRate = 115200
ser = serial.Serial(serialPort,baudRate,timeout=0.5)
 
text =[]

def getText(role,content):
    jsoncon = {}
    jsoncon["role"] = role
    jsoncon["content"] = content
    text.append(jsoncon)
    return text

def getlength(text):
    length = 0
    for content in text:
        temp = content["content"]
        leng = len(temp)
        length += leng
    return length

def checklen(text):
    while (getlength(text) > 8000):
        del text[0]
    return text

############################################语音合成板块

STATUS_FIRST_FRAME = 0  # 第一帧的标识
STATUS_CONTINUE_FRAME = 1  # 中间帧标识
STATUS_LAST_FRAME = 2  # 最后一帧的标识


class Ws_Param(object):
    # 初始化
    def __init__(self, APPID, APIKey, APISecret, Text):
        self.APPID = APPID
        self.APIKey = APIKey
        self.APISecret = APISecret
        self.Text = Text

        # 公共参数(common)
        self.CommonArgs = {"app_id": self.APPID}
        # 业务参数(business)
        self.BusinessArgs = {"aue": "lame","auf": "audio/L16;rate=16000", "vcn": "x4_doudou", "tte": "utf8"}
        self.Data = {"status": 2, "text": str(base64.b64encode(self.Text.encode('utf-8')), "UTF8")}

    # 生成url
    def create_url(self):
        url = 'wss://tts-api.xfyun.cn/v2/tts'
        # 生成RFC1123格式的时间戳
        now = datetime.now()
        date = format_date_time(mktime(now.timetuple()))

        # 拼接字符串
        signature_origin = "host: " + "ws-api.xfyun.cn" + "\n"
        signature_origin += "date: " + date + "\n"
        signature_origin += "GET " + "/v2/tts " + "HTTP/1.1"
        # 进行hmac-sha256进行加密
        signature_sha = hmac.new(self.APISecret.encode('utf-8'), signature_origin.encode('utf-8'),
                                 digestmod=hashlib.sha256).digest()
        signature_sha = base64.b64encode(signature_sha).decode(encoding='utf-8')

        authorization_origin = "api_key=\"%s\", algorithm=\"%s\", headers=\"%s\", signature=\"%s\"" % (
            self.APIKey, "hmac-sha256", "host date request-line", signature_sha)
        authorization = base64.b64encode(authorization_origin.encode('utf-8')).decode(encoding='utf-8')
        # 将请求的鉴权参数组合为字典
        v = {
            "authorization": authorization,
            "date": date,
            "host": "ws-api.xfyun.cn"
        }
        # 拼接鉴权参数，生成url
        url = url + '?' + urlencode(v)
   
        return url

def on_message(ws, message):
    try:
        message =json.loads(message)
        code = message["code"]
        sid = message["sid"]
        audio = message["data"]["audio"]
        audio = base64.b64decode(audio)
        status = message["data"]["status"]
        print(message)
        if status == 2:
            print("ws is closed")
            ws.close()
        if code != 0:
            errMsg = message["message"]
            print("sid:%s call error:%s code is:%s" % (sid, errMsg, code))
        else:

            with open('./demo.mp3', 'ab') as f:
                f.write(audio)

    except Exception as e:
        print("receive msg,but parse exception:", e)



# 收到websocket错误的处理
def on_error(ws, error):
    print("### error:", error)


# 收到websocket关闭的处理
def on_close(ws):
    print("### closed ###")


# 收到websocket连接建立的处理
def on_open(ws):
    def run(*args):
        d = {"common": wsParam.CommonArgs,
             "business": wsParam.BusinessArgs,
             "data": wsParam.Data,
             }
        d = json.dumps(d)
        print("------>开始发送文本数据")
        ws.send(d)
        if os.path.exists('./demo.mp3'):
            os.remove('./demo.mp3')

    thread.start_new_thread(run, ())


############################################
    
flag = 0

if __name__ == '__main__':
    text.clear
    while(1):
        data_dec = ser.read_all()
        if data_dec:
            rec_str = data_dec.decode('utf-8')
            if rec_str != 1:
                if rec_str == "2":
                    Input = "我现在很高兴,拍拍我的马屁"
                elif rec_str == "3":
                    Input = "我现在很难过,讲几句让我高兴的话，不要问我为什么难过"
                elif rec_str == "0":
                    Input = "我现在很生气,讲几句让我冷静的话，不要问我为什么生气"
                question = checklen(getText("user",Input))
                SparkApi.answer =""
                print("星火:",end = "")
                SparkApi.main(appid,api_key,api_secret,Spark_url,domain,question)
                getText("assistant",SparkApi.answer)
                ################################### 语言合成模块调用，出于保密考虑，下面的所有API都已隐去，如有问题请联系作者
                wsParam = Ws_Param(APPID='*******', APISecret='********',
                           APIKey='*********',
                           Text=SparkApi.answer)
                websocket.enableTrace(False)
                wsUrl = wsParam.create_url()
                ws = websocket.WebSocketApp(wsUrl, on_message=on_message, on_error=on_error, on_close=on_close)
                ws.on_open = on_open
                ws.run_forever(sslopt={"cert_reqs": ssl.CERT_NONE})
                playsound('demo.mp3')
                rec_str = 1
                ###################################

ser.close()