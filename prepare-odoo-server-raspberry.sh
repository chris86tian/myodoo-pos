#!/bin/bash
# Mit diesem Skript werden alle Pakete für den Odoo Betrieb unter Ubuntu installiert
# Skript muss mit root-Rechten ausgeführt werden also vorher sudo su eingeben!
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

echo "Prepare Raspberry Linux"
apt-get update && apt-get dist-upgrade && apt-get autoremove
sudo rpi-update

echo "Tools zip, unzip, mc(Midnight Comander) and htop will be install.."
apt-get install mc zip unzip htop ntp dnsutils

echo "Do you want install postgresql ? / Wollen Sie die PostgreSQL-DB installieren  (Y/n):"
read mypsql

if [ "$mypsql" = "Y" ]; then
  echo "PostgreSQL will be install..."
  apt-get install postgresql
else
  echo "PostgreSQL is not installed!"
fi

echo "Do you want optimize postgres settings? / Wollen Sie die PostgreSQL-Einstellungen optimieren (Y/n)?:"
read mysql

if [ "$mysql" = "Y" ]; then
  echo "PostgreSQL will be optimized..."
  apt-get install pgtune
  sudo pgtune -i /etc/postgresql/9.1/main/postgresql.conf -o /etc/postgresql/9.1/main/postgresql.conf.tuned
  sudo mv /etc/postgresql/9.1/main/postgresql.conf  /etc/postgresql/9.1/main/postgresql.conf.old
  sudo mv /etc/postgresql/9.1/main/postgresql.conf.tuned  /etc/postgresql/9.1/main/postgresql.conf
  sudo /etc/init.d/postgresql stop
  sudo /etc/init.d/postgresql start
  sudo cat /etc/postgresql/9.1/main/postgresql.conf
else
  echo "PostgreSQL is not optimized!"
fi

echo "apt-get packages will be install.."

apt-get install -y --no-install-recommends \
	ghostscript \
	graphviz \
	antiword \
	libpq-dev \
	poppler-utils \
	python-pip \
	build-essential \
	libfreetype6-dev \
	python-dateutil \
	python-pypdf \
	python-requests \
	python-feedparser \
	python-gdata \
	python-ldap \
	python-libxslt1 \
	python-lxml \
	python-mako \
	python-openid \
	python-psycopg2 \
	python-pybabel \
	python-pychart \
	python-pydot \
	python-pyparsing \
	python-reportlab \
	python-simplejson \
	python-tz \
	python-vatnumber \
	python-vobject \
	python-webdav \
	python-werkzeug \
	python-xlwt \
	python-yaml \
	python-zsi \
	python-docutils \
	python-psutil \
	python-unittest2 \
	python-mock \
	python-jinja2 \
	python-dev \
	python-pdftools \
	python-decorator \
	python-openssl \
	python-babel \
	python-imaging \
	python-reportlab-accel \
	python-paramiko \
	python-software-properties \
	python-magic \
	python-matplotlib \
	python-support \
	python-passlib \
	python-pyinotify \
	python-gevent

echo "pip packages will be install.."
pip install passlib \
	&& pip install beautifulsoup4 \
	&& pip install evdev \
	&& pip install reportlab \
	&& pip install qrcode \
	&& pip install polib \
	&& pip install unidecode \
	&& pip install validate_email \
	&& pip install pyDNS \
	&& pip install pysftp \
	&& pip install python-slugify \
	&& pip install six==1.4 \
	&& pip install paramiko==1.9.0 \
	&& pip install pycrypto==2.4 \
	&& pip install pyinotify \
	&& pip install ecdsa==0.11 \
	&& pip install sphinx \
	&& pip install babel==1.3 \
	&& pip install Pygments==2.0 \
	&& pip install docutils==0.11 \
	&& pip install markupsafe \
	&& pip install pytz \
	&& pip install Jinja2==2.3 \
	&& pip install odoorpc \
	&& pip install gevent \
	&& pip install egenix-mx-base \
	&& pip install pyserial \
	&& pip install pyusb

echo "Python Image Library will be install.."
wget http://effbot.org/downloads/Imaging-1.1.7.tar.gz
tar fzvx Imaging-1.1.7.tar.gz
cd Imaging-1.1.7
python setup.py install
cd ..
rm Imaging-1.1.7.tar.gz
rm -r Imaging-1.1.7/
pip install -I pillow

echo "Do you want install barcodes? / Wollen Sie die Barcodes installieren (Y/n):"
read myfonts

if [ "$myfonts" = "Y" ]; then
  echo "Barcodes will be install..."
  wget http://www.reportlab.com/ftp/pfbfer.zip
  unzip pfbfer.zip -d fonts
  mv fonts /usr/lib/python2.7/dist-packages/reportlab/
  rm pfbfer.zip
else
  echo "Barcodes is not installed!"
fi

echo "Finished!"
