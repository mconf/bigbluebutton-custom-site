#!/bin/bash

sudo cp -r bbb-api-demo/src/main/webapp/* /var/lib/tomcat6/webapps/demo/
sudo chown -R tomcat6:tomcat6 /var/lib/tomcat6/webapps/demo
sudo service tomcat6 restart
