#!/bin/bash

#file="/var/log/anaconda/X.log"
#awk '$3 == "(WW)" {print}' $file | sed 's/(WW)/Warning/' > full.log
#awk '$3 == "(II)" {print}' $file | sed 's/(II)/Info/' >> full.log

file="/var/log/auth.log"
awk '$2 == "29" && $8 == "opened" {print}' $file | sed 's/session opened/CONNECT/' > full.log
awk '$2 == "29" && $8 == "closed" {print}' $file | sed 's/session closed/DISCONNECT/' >> full.log
