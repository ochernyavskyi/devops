<h1>Docker task</h1>

<p>This docker image includes flask program, which is dealing with CURL requests
at port 8080.
<p>Example of CURL request is below:
<p><b>curl -k -XPOST -d'{"animal":"elephant", "sound":"whoooaaa", "count": 5}' http://localhost:8080</b>

<h2>Quick start</h2>
<ul>
<li>Make sure that docker is installed</li>
<li>Run the following command at project folder:
<p><b>docker build -t 'name_of_image" . </b> </li>
<li>Run the container by this command:
<p><b>docker run -d --rm -p 8080:8080 'name_of_container' 'name_of_image"</b></li>
<li>Enjoy</li>
</ul>

<p>Or U can just run ./myscript.sh to automate the process:)
