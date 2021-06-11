<h1>Task 1  - Ansible assignment</h1>

<h2>Quick guide</h2>
<h3> Edit the inventory file (<i>hosts.txt</i>)</h3><p>
Add hosts to [webservers] group in "hosts.txt" file:

<i>[webservers]</br>
192.168.88.109</br></br>

<h3>Edit vault-pass.yml </h3>
Open the file and insert your data:</br>

<i>ssh_user: your_ssh_user</br>
ssh_password: your_ssh_password</br>
my_password: your_sudo_password</i></br>

<h3> Encrypt your file:</h3>

*ansible-vault encrypt vault-pass.yml*</br></br>
The system will ask U to enter new password to encrypt the file.</br>

<h3>Add your ssh-key</h3>
Generate at your own machine ssh-key by following command:</br><p>
<i>ssh-keygen</i></br></br>
Copy generated key (id_rsa.pub) to "key_certs" folder.


<h3>Execute playbook</h3>
Run beloow command:</br>
ansible-playbook --ask-vault-pass --extra-vars '@vault-pass.yml' playbook.yml</p>

The system will ask U to enter your password for encrypted file. Enter it and enjoy the process.

<h4>Example of work</h4><p>
<b><i>curl -k -XPOST -d'{"animal":"cow", "sound":"moooo", "count": 3}' https://yourhost_or_ip </b><p>
🐄 says moooo</br>
🐄 says moooo</br>
🐄 says moooo</br></br>
Made with ❤️ by Oleg</i>

<b><i>curl -k -XPOST -d'{"animal":"cow", "sound":"moooo", "count": 3}' https://yourhost_or_ip </b><p>
🐘 says whoooaaa</br>
🐘 says whoooaaa</br>
🐘 says whoooaaa</br>
🐘 says whoooaaa</br>
🐘 says whoooaaa</br></br>
Made with ❤️ by Oleg</i>