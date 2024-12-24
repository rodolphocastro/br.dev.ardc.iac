#!/bin/bash

cd ./aws
terraform fmt -recursive -check

cd ../azure
terraform fmt -recursive -check
