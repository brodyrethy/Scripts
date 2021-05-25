#!/bin/bash
pgrep -u $USER picom && pkill picom || picom
