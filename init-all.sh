#!/bin/bash

cd ./aws
terraform init -backend=false

cd ../azure
terraform init -backend=false
