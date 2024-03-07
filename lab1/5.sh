#!/bin/bash

# awk '$2 = "INFO" {print}' /var/log/anaconda/syslog > info.log

awk '$2 == "22" {print}' /var/log/auth.log > info.log
