#!/bin/bash

echo "source <(kubectl completion bash)" >>~/.bashrc
alias k=kubectl
complete -o default -F __start_kubectl k
