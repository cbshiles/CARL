#!/bin/bash

nasm -felf -ocode/$1".o" -g $1".asm" -w+orphan-labels -l $1".lst"
ld -o $1 code/{$1,tools,sys_calls}".o"
