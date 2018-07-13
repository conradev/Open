TARGET := iphone:clang:latest:5.0
ARCHS := armv7 armv7s arm64
DEBUG = 0

SDKVERSION = 9.2
export SYSROOT = $(THEOS)/sdks/iPhoneOS9.2.sdk

include $(THEOS)/makefiles/common.mk

TOOL_NAME = open
open_FILES = open.m
open_PRIVATE_FRAMEWORKS = SpringBoardServices
open_CODESIGN_FLAGS = -SEntitlements.plist

include $(THEOS)/makefiles/tool.mk


all::
	# Resign it manually by jtool(http://www.newosxbook.com/tools/jtool.html)
	./jtool --sign --ent ./Entitlements_iOS11.plist .theos/obj/arm64/open
	mv out.bin .theos/obj/arm64/open
	./jtool --sign --ent ./Entitlements.plist .theos/obj/armv7/open
	mv out.bin .theos/obj/armv7/open
	./jtool --sign --ent ./Entitlements.plist .theos/obj/armv7s/open
	mv out.bin .theos/obj/armv7s/open
	lipo -create .theos/obj/arm64/open .theos/obj/armv7/open .theos/obj/armv7s/open -output .theos/open