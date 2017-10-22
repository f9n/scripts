#!/usr/bin/env bash
# $ git clone https://github.com/pleycpl/scripts-shell
# echo 'alias url="~/scripts-shell/url.sh" ' >> .bashrc
STACK_DIR=$HOME/.local/share/stack
if [ ! -e $STACK_DIR ]; then
    mkdir -p $STACK_DIR
fi

Status=$1
Link=$2
if [ $Status = "push" ]; then
    echo $Link >> $STACK_DIR/main.txt
elif [ $Status = "get" ]; then
    cat $STACK_DIR/main.txt
fi