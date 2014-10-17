#!/bin/bash

nasm -felf -o code/$1".o" -g $1".asm" -w+orphan-labels -l lst/$1".lst"
ld -o $1 code/{$1,tools,sys_calls}".o"
