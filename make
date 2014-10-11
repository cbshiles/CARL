#!/bin/bash
# -l for lst files -O93 for optimization 
# nasm -ic:\macrolib\ -f obj myfile.asm
nasm -felf -o$1".o" -g $1".asm" 
ld -o $1 $1".o"