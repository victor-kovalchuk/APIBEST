#!/bin/bash

service mysql start
service nginx start
php artisan serve

