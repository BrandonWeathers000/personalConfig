#!/bin/bash

apropos . | awk '{ print $1 } ' | fuzzel -p "Manual: " --dmenu | xargs -r man
