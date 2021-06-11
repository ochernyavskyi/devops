import json
import emoji
from flask import Flask, request

app = Flask(__name__)

@app.route("/")
def index():
	return '''
		<h2>Hello from flask</h2>
		This service listens at least on port 443 (80 as an option)</br>
		* the service accepts GET and POST methods</br>
		* the service should receive `JSON` object and return strings in the following manner:</br></br>

		<b>curl -k -XPOST -d'{"animal":"elephant", "sound":"whoooaaa", "count": 5}' https://your_ip_or_hostname </b></br>
		cow says moooo</br>
		cow says moooo</br>
		cow says moooo</br></br>
		Made with ❤️ by Oleg</br></br>

		<b>curl -k -XPOST -d'{"animal":"elephant", "sound":"whoooaaa", "count": 5}' https://your_ip_or_hostname </b></br>
		elephant says whoooaaa</br>
		elephant says whoooaaa</br>
		elephant says whoooaaa</br>
		elephant says whoooaaa</br>
		elephant says whoooaaa</br></br>
		Made with ❤️ by Oleg
		'''
	


@app.route("/", methods=['POST'])
def json_example():
	#Receive request
	content = request.get_json(force=True)
	#Parsing the request
	animal = content["animal"]
	sound = content["sound"]
	count = str(content["count"])
	emoji =  {'elephant':'\N{elephant}', 'cow':'\N{cow face}', 'giraffe':'\N{giraffe face}'}
	emoji_icon = emoji.get(animal)
	#Checking if emoji is at our dict
	if emoji_icon is None:
		return  "\nThe animal isn't supported by emoji, please contact +380504905951\n"
	i=0
	res=''
	while i<int(count):
		temp = emoji_icon + animal + " says  "  +  sound + "\n"
		res =  temp + res
		i=i + 1
	res = "\n" + res + "\n Made with \u2764\uFE0F  by  Oleg\n"
	return  res

app.run(host='0.0.0.0', port = 443, ssl_context = ('cert.pem', 'key.pem'))
