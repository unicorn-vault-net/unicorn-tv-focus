# Copyright (C) 2026 The Unicorn TV Focus Project
# Input Device Configuration for the virtual touchscreen created by uinputd.
# Installed to /system/usr/idc/unicorn-focus-touch.idc (name must match the uinput device name).
#
# Declaring it a touchScreen (rather than a pointer) makes InputReader treat our injected MT
# protocol-B events as genuine finger touches, so app-side gesture/scroll/fling detectors behave
# exactly as with the physical panel.

touch.deviceType = touchScreen
touch.orientationAware = 1

# The virtual device reports coordinates in the ABS_MT_POSITION_X/Y range set in uinputd.cpp
# (0..absMaxX, 0..absMaxY). Keep those maxima equal to the panel's native resolution so no
# scaling is needed; otherwise set an explicit source/output mapping here.
