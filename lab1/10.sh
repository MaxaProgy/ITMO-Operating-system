#!/bin/bash

man bash | grep -iow "[[:alpha:]]\{4,\}" | tr "[:upper:]" "[:lower:]" | sort | uniq -c | sort -nr | head -3
