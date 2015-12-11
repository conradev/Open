TARGET := iphone:clang:latest:5.0
ARCHS := armv7 armv7s arm64

include theos/makefiles/common.mk

TOOL_NAME = open
open_FILES = open.m
open_PRIVATE_FRAMEWORKS = SpringBoardServices MobileCoreServices
open_CODESIGN_FLAGS = -SEntitlements.plist
open_FRAMEWORKS 	= UIKit

include $(THEOS_MAKE_PATH)/tool.mk
