#!/bin/bash
# Mit diesem Skript installiert Odoo unter /opt/odoo und bindet es in den Autostart ein
# Skript muss mit root-Rechten ausgeführt werden
##############################################################################
#
#    Shell Script for Odoo, Open Source Management Solution
#    Copyright (C) 2014-now Equitania Software GmbH(<http://www.equitania.de>).
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
##############################################################################

myscriptpath="$PWD"
mybasepath="/opt/odoo"
mysourcepath=$mybasepath"/odoo"
myserverpath=$mybasepath"/odoo-server"
myaddpath=$mybasepath"/odoo-addons"

echo "Basepath: "$mybasepath
echo "Sourcepath: "$mysourcepath
echo "Serverpath: "$myserverpath
echo "odoo-addons path: "$myaddpath

echo "Prepare PostgreSQL"
sudo -u postgres createuser -s pi
sudo -u postgres psql -c "ALTER USER pi WITH PASSWORD 'raspberry';"



echo "Finished!"
