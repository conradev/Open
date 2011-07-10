include theos/makefiles/common.mk

TOOL_NAME = open
open_FILES = open.m
open_PRIVATE_FRAMEWORKS = AppSupport

TWEAK_NAME = Open
Open_FILES = Tweak.xm
Open_LDFLAGS = -ldisplaystack
Open_FRAMEWORKS = UIKit
Open_PRIVATE_FRAMEWORKS = AppSupport

include $(THEOS_MAKE_PATH)/tool.mk
include $(THEOS_MAKE_PATH)/tweak.mk

