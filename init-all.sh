#!/bin/bash
if [ ! -d "./aws/.terraform" ]; then
    cd ./aws
    terraform init -backend=false
    cd ..
fi

if [ ! -d "./azure/.terraform" ]; then
    cd ./azure
    terraform init -backend=false
    cd ..
fi
