#!/bin/bash

echo "export SECRET_KEY_BASE=`bundle exec rake secret`/g" >> ~/.bash_profile
