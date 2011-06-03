Maintenance mode for BigBlueButton
==================================

### How it works:

You set a rewrite rule in Nginx that searchs for a file named `maintenance.html` in the document root (usually `/var/www/bigbluebutton-default/`). If it exists, *all* BigBlueButton pages will be disabled (home page, API, demos, etc.) and Nginx will render only `maintenance.html`.

There's also a script to easily enable and disable maintenance mode.

### Files

* `nginx/bigbluebutton` is an example for the BigBlueButton configuration file for Nginx. You just need to add these lines in it:

    ```
    if (-f /var/www/bigbluebutton-default/maintenance.html) {
        rewrite ^(.*)$ /maintenance.html break;
    }
    ```

    This file is usually at `/etc/nginx/sites-available/bigbluebutton`.

* `maintenance.html.template` is the template used to generate `maintenance.html`. Put it in the document root, usually `/var/www/bigbluebutton-default/`.

* `bbb-maintenance` is a script that enables or disables the maintenance mode by creating or removing `maintenance.html`. Put it with `bbb-conf`, usually at `/usr/local/bin/`. Don't forget to give it permsision to be executed:

    ```
    sudo chmod +x /usr/local/bin/bbb-maintenance
    ```

    Usage:

    ```
    bbb-maintenance --on   # enable maintenance
    bbb-maintenance --off  # disable maintenance
    ```
