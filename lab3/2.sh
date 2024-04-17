#!/bin/bash

report_file=$HOME/report

at now +2 minutes -f ./1.sh
tail -f $report_file