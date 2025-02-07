#!/bin/bash

winetricks d3dcompiler_47

ibus-daemon -d -x &

wine aivoice.exe
