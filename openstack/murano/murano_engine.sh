#!/bin/bash

cd ~/murano/murano
tox -e venv -- murano-engine --config-file ./etc/murano/murano.conf

