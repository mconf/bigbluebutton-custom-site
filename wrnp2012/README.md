What?
=====

Changes in BigBlueButton's demos and index page to be used in WRNP 2012.

How-to
======

Copy the contents:

    sudo cp -r bbb-api-demo/src/main/webapp/* /var/lib/tomcat6/webapps/demo/
    sudo cp -r bigbluebutton-config/web/* /var/www/bigbluebutton-default/

Config the passwords and max users in:

    /var/lib/tomcat6/webapps/demo/wrnp2012.jsp
