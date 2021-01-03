#!/bin/bash

QEMU_PID=$(ps -ef | grep qemu | grep -v grep | grep -v kill | awk '{print $2}')

if [[ ! -z "$QEMU_PID" ]]; then
	kill -9 $QEMU_PID
fi
