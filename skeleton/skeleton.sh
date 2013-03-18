#!/bin/bash

#set -x
set -e
set -u

if test $# -lt 1; then
	echo 1>&2 "Usage $0 file1"
	exit 1
fi
