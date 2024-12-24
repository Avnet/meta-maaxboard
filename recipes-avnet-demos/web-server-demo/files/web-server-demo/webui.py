#############################################################
# ___  ____ ____ ____ ____ ____ _  _ _ ____ _ ___ ____ ____ 
# |__] |__/ |___ |__/ |___ |  | |  | | [__  |  |  |___ [__  
# |    |  \ |___ |  \ |___ |_\| |__| | ___] |  |  |___ ___] 
#                                                           
#############################################################
#pip3 install pyserial
#pip3 install psutil==5.8.0
#pip3 install PyCrypto
#pip3 install microdot
#pip3 install opencv-python==4.7.0.72
#pip3 install opencv-python-headless==4.7.0.68
#####################################################

#####################################################
#to stop teh service use this command
#systemctl stop  autorun.service
#####################################################

########################################################
#Options
########################################################
run_on_hardware = True

if run_on_hardware == False:
	use_sample_video = True
	HardwareSupport = False
	RotateCameraY = False
	RotateCameraX = False
	EnableUSBPowerMonitor = False
else:
	use_sample_video = False
	HardwareSupport = True
	RotateCameraY = False
	RotateCameraX = True
	EnableUSBPowerMonitor = True
########################################################

import os
import sys
import json
import serial
from serial import SerialException
import cv2
import psutil
from netinfo import NETInfo
from TC66CClass import TC66C
from MaaXBoardLEDS import BoardLEDS
from MaaXBoardLCD import BoardBrightness
import singleton
import subprocess
import signal
import time
from collections import namedtuple

try:
	import uasyncio as asyncio
except ImportError:
	import asyncio

from microdot_asyncio import Microdot, redirect, send_file

# generate random integer values
from random import seed
from random import randint

# will sys.exit(-1) if other instance is running
me = singleton.SingleInstance()

seed(1)

serialPortBusy = False
usingClip = True
ledStates = [0, 0, 0]


fileDir = os.path.dirname(os.path.realpath(__file__))

def startChrome(url):
	""" Calls Chrome, opening the URL contained in the url parameter. """

	if run_on_hardware == True:
		executable = '/usr/bin/chromium'
	else:
		executable = '/snap/bin/chromium'    # Change to fit your system

	cmd = ' '.join([executable,'--no-sandbox --disable-features=OverscrollHistoryNavigation --kiosk --app=', url])
	browswer_proc = subprocess.Popen(cmd, shell=True)

def GetFileFullPath(s):
	filePath = os.path.join(fileDir, s)
	filePath = os.path.abspath(os.path.realpath(filePath))
	return filePath


global decodeData
input_video_path = GetFileFullPath('web/sample.mp4')


def OpenCVDevice(self, useFile):
	global usingClip
	try:
		if(self.cap.isOpened() == True):
			CloseCVDevice(self)
	except:
		pass
	
	if useFile == False and use_sample_video == False and os.path.isfile("/tmp/access_demo") == False:
		if run_on_hardware == True:
			os.environ['OPENCV_FFMPEG_CAPTURE_OPTIONS'] = 'hwaccel;qsv|video_codec;h264_qsv|vsync;0'
		self.cap = cv2.VideoCapture(cv2.CAP_V4L2)
		self.cap.set(cv2.CAP_PROP_FRAME_WIDTH, 320)
		self.cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 240)
		self.cap.set(cv2.CAP_PROP_FPS, 30)
		usingClip = False
	else:
		os.environ['OPENCV_FFMPEG_CAPTURE_OPTIONS'] = ''
		self.cap = cv2.VideoCapture(input_video_path)
		usingClip = True

def CloseCVDevice(self):
	try:
		self.cap.release()
	except:
		pass
	
class AppData:
	def __init__(self):
		OpenCVDevice(self, use_sample_video)


###############################################################################
# HTTP server
###############################################################################
app = Microdot()

@app.route('/video_feed')
async def video_feed(request):
	global usingClip
	if sys.implementation.name != 'micropython':
		# CPython supports yielding async generators
		async def stream():
			yield b'--frame\r\n'
			OpenCVDevice(decodeData, False)
			while True:
				while (decodeData.cap.isOpened()):
					ret, frame = decodeData.cap.read()
					if ret:
						if use_sample_video == False and usingClip == False:
							frame = frame[:, ::-1, :]
							frame = cv2.cvtColor(frame[:,:,::-1], cv2.COLOR_BGR2RGBA).astype('uint8')
						if RotateCameraY and not usingClip:
							frame = cv2.flip(frame, 1)
						if RotateCameraX and not usingClip:
							frame = cv2.flip(frame, 0)

							dim = (640, 480)
							frame = cv2.resize(frame, dim, interpolation = cv2.INTER_AREA)

							_, frame = cv2.imencode('.JPEG', frame)
							yield (b'--frame\r\n'
								b'Content-Type: image/jpeg\r\n\r\n' + frame.tobytes() + b'\r\n')
						else:
							_, frame = cv2.imencode('.JPEG', frame)
							yield (b'--frame\r\n'
								b'Content-Type: image/jpeg\r\n\r\n' + frame.tobytes() + b'\r\n')

					await asyncio.sleep(0.05)
				await asyncio.sleep(0.05)

	else:
		# MicroPython can only use class-based async generators
		class stream():
			def __init__(self):
				self.i = 0

			def __aiter__(self):
				return self

			async def __anext__(self):
				await asyncio.sleep(1)

	return stream(), 200, {'Content-Type':
						   'multipart/x-mixed-replace; boundary=frame'}


@app.route('/ethernet.cgi', methods=['GET'])
async def ethernet(request):
	response = None
	if request.method == 'GET':
		cmdType = 'ethernet'
		info = NETInfo.GetNetworkInfo()
		data_set = {"cmdType": cmdType, "ethernetInfo": [info]}

		sys_cookie = json.dumps(data_set)
		response = sys_cookie
	return response

@app.route('/uses/rundemo.cgi', methods=['GET', 'POST'])
def demoCgi(request):
	if request.method == 'POST':
		resp = json.loads(request.body)
		if ("cmdType" in resp):
			data_set = {"cmdType": 'rundemo'}
			if resp['cmdType'] == 'rundemo':
				CloseCVDevice(decodeData)
				subprocess.Popen("python3 ~/8ULPAccessDemo/8ULPAccessDemo.py", shell=True)
				OpenCVDevice(decodeData, True)

		demo_cookie = json.dumps(data_set)
		response = demo_cookie
	return response

@app.route('/led.cgi', methods=['GET', 'POST'])
def ledCgi(request):
	global ledStates
	if request.method == 'GET':
		cmdType = 'getLed'
		data_set = {"cmdType": cmdType, "values": [
		    ledStates[0], ledStates[1], ledStates[2]]}
		led_cookie = json.dumps(data_set)
		response = led_cookie

	elif request.method == 'POST':
		resp = json.loads(request.body)
		if ("cmdType" in resp) and ("ledNum" in resp) and ("ledState" in resp):
			if resp['cmdType'] == 'setLed':
				ledNum = resp['ledNum']
				ledState = resp['ledState']
				if ledNum < 3:
					ledStates[ledNum] = ledState

		# set led values here
		cmdType = 'getLed'
		data_set = {"cmdType": cmdType, "values": [ledStates[0], ledStates[1], ledStates[2]]}

		if ledStates[0] == 1:
			hardwareLEDS.LED_on("red")
		else:
			hardwareLEDS.LED_off("red")

		if ledStates[1] == 1:
			hardwareLEDS.LED_on("green")
		else:
			hardwareLEDS.LED_off("green")

		if ledStates[2] == 1:
			hardwareLEDS.LED_on("blue")
		else:
			hardwareLEDS.LED_off("blue")
		
		led_cookie = json.dumps(data_set)
		response = led_cookie
	return response




@app.route('/brightness.cgi', methods=['GET', 'POST'])
def brightnessCgi(request):
	if request.method == 'GET':
		brightness = hardwareLCD.Brightness_get()+1
		cmdType = 'setBrightness'
		data_set = {"cmdType": cmdType, "brightnessValue": brightness}
		brightness_cookie = json.dumps(data_set)
		response = brightness_cookie

	elif request.method == 'POST':
		resp = json.loads(request.body)
		if resp['cmdType'] == 'setBrightness':
			brightness = int(resp['brightnessValue'])
		else:
			brightness = 10

		if brightness > 1:
			brightness = brightness -1
		else:
			brightness = 9

		hardwareLCD.Brightness_set(brightness)

		cmdType = 'setBrightness'
		data_set = {"cmdType": cmdType, "brightnessValue": brightness}

		brightness_cookie = json.dumps(data_set)
		response = brightness_cookie
	return response





@app.route('/sys.cgi', methods=['GET'])
async def system(request):
	global serialPortBusy
	response = None
	if request.method == 'GET':
		cmdType = 'sys'
		cpu = psutil.cpu_percent(0,False)
		mem = psutil.virtual_memory()[2]

		disk_parts = psutil.disk_partitions()
		for disk_part in disk_parts:
			try:
				disk_usage = psutil.disk_usage(disk_part.mountpoint)
			except OSError:
				pass

		disk = disk_usage.percent

		data_set = {"cmdType": cmdType, "systemInfo": [cpu, mem, disk]}

		sys_cookie = json.dumps(data_set)
		response = sys_cookie
	return response


@app.route('/imu.cgi', methods=['GET'])
def imu(request):
	global serialPortBusy
	response = None
	if request.method == 'GET' and serialPortBusy == False:
		serialPortBusy = True
		cmdType = 'imu'

		try:
			ser = serial.Serial('/dev/ttyRPMSG30')  # open serial port
			print(ser.name)         # check which port was really used
			str1 = str(randint(-1000, 1000))
			str2 = str(randint(-1000, 1000))
			str3 = str(randint(-1000, 1000))
			txString = str1+','+str2+','+str3+'\r\n'
			# txString='\r\n'
			ser.write(txString.encode())  # send random data
			line = ser.readline()
			print("received data: " + line.decode("utf-8"))
			data_set = line
			valuelist = line.decode("utf-8").split(",")
			ser.close()
		except serial.SerialException as e:
			pass
		except OSError:
			pass

		serialPortBusy = False
		data_set = {"cmdType": cmdType, "sensor": [randint(-1000, 1000),randint(-1000, 1000),randint(0, 500)]}

		imu_cookie = json.dumps(data_set)
		response = imu_cookie
	return response


@app.route('/power.cgi', methods=['GET'])
def power(request):
	response = None
	if request.method == 'GET':
		cmdType = 'power'

		if EnableUSBPowerMonitor == True:
			try:
				pd = TC66.Poll()
				if pd == None: 
					FakePollData = namedtuple('PollData',['Volt','Current','Power'])	
					pd = FakePollData(
						Volt	= 0.0,
						Current	= 0.0,
						Power	= 0.0)

				s = '{:07.4f},{:07.5f},{:07.4f}'.format(
					pd.Volt, 
					pd.Current,
					pd.Power)
				print(s)

			except OSError:
				pass
			data_set = {"cmdType": cmdType, cmdType: [pd.Volt,pd.Current,pd.Power]}
		else:
			data_set = {"cmdType": cmdType, cmdType: [0,0,0]}

		power_cookie = json.dumps(data_set)
		response = power_cookie
	return response

@app.route('/uses/<name>', methods=['GET', 'POST'])
def index(request,name):
	if request.method == 'POST':
		response = redirect('/')
	else:
		response = send_file(GetFileFullPath('web/uses/'+name))

	return response

@app.route('/<name>', methods=['GET', 'POST'])
def index(request,name):
	if request.method == 'POST':
		response = redirect('/')
	else:
		response = send_file(GetFileFullPath('web/'+name))

	return response

@app.route('/', methods=['GET', 'POST'])
def index(request):
	if request.method == 'POST':
		response = redirect('/')
	else:
		response = send_file(GetFileFullPath('web/index.html'))

	return response

TC66 = TC66C()

hardwareLEDS = BoardLEDS(HardwareSupport)
hardwareLEDS.LED_init()

hardwareLCD = BoardBrightness(HardwareSupport)
hardwareLCD.Brightness_init()

decodeData = AppData()

startChrome('http://localhost:5000')

app.run(debug=True)
