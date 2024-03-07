#!/bin/bash

grep -Eosh "[[:alnum:]._%+-]+@[[:alnum:].-]+\.[[:alpha:]]{2, 4}" /etc/* | tr "\n" ", " > emails.lst
