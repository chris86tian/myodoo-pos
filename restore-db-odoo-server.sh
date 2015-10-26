#!/bin/bash
# Mit diesem Skript wird ein Restore einer Odoo Datenbank durchgeführt
# Verwenden Sie den Benutzer odoo > sudo su odoo
# With this script you can restore a odoo db on postgresql
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

mybasepath="/opt/odoo"
mybackuppath=$mybasepath"/backup"

echo "Basepath: "$mybasepath
echo "Backup path: "$mybackuppath


echo "Name of the new db:"
read mydb

echo "Delete the old version of $mydb [Y/n]:"
read mydel

if [ "$mydel" == "Y" ] || [ "$mydel" == "y" ]; then
  dropdb -U odoo $mydb
  echo "Drop is done."
fi

echo "Name of the backupfile (path: $mybackuppath):"
read mybackupgz

if [ "$mydb" != "" ]; then
  echo "Unzip $mybackuppath/$mybackupgz.."
  gunzip $mybackuppath/$mybackupgz
  mybackup=`echo $mybackupgz | cut -d"." -f1,2`
  echo "Create DB $mydb with $mybackup file.."
  createdb -U odoo -T template0 $mydb
  echo "Restore DB $mydb"
  psql -U odoo -f $mybackuppath/$mybackup -d $mydb -h localhost -p 5432
  echo "Restore is done."
  echo "Do you want to deactivate mailserver functions in $mydb [Y/n]:"
  read mymail
  if [ "$mymail" == "Y" ] || [ "$mymail" == "y" ]; then
    psql -d $mydb -U odoo -c $'UPDATE ir_cron SET active = FALSE WHERE ("name" = \'Fetchmail Service\' OR "name" = \'Garbage Collect Mail Attachments\' OR "name" = \'Email Queue Manager\');'
    psql -d $mydb -U odoo -c $'DELETE FROM ir_mail_server;'
    psql -d $mydb -U odoo -c $'DELETE FROM fetchmail_server;'
  fi
else
  echo "No restore."
fi

echo "Finished!"
