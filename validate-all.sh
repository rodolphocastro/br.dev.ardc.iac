#!/bin/bash

cd ./aws
terraform validate

cd ../azure
terraform validate