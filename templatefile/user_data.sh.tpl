#!/bin/bash
yum install httpd -y



myip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
cat <<EOF > /var/www/html/index.html
<html>
<h2>Build powered by Terraform</h2></br>
Owner ${f_name} ${l_name} <br>

%{ for x in names ~}
Hello to ${x} from ${f_name}<br>
%{ endfor ~}

</html>
EOF


sudo service httpd start
