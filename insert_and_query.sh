#!/bin/bash
# Program to diff output against exected_output.txt

X=0 

while (( X <= 10 )) 
do 
  echo $X
  $(( X++ ))
done


