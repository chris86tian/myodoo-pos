#!/bin/bash -x
/home/pi/odoo/odoo.py -c /home/pi/odoo/posbox/posbox.conf --log-level=info --load=web,hw_posbox_homepage
#/home/pi/odoo/odoo.py --db-filter=posbox -d posbox --data-dir='/var/run/odoo' --log-level=info --load=web,hw_posbox_homepage,hw_posbox_upgrade

