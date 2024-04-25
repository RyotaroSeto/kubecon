#!/bin/zsh

echo "if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi" >>~/.zshrc # add autocomplete permanently to your zsh shell.

alias k=kubectl
