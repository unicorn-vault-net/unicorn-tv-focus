# Illustrative product-copy fragment. Adapt TVFOCUS_RELEASE_ROOT to the
# location where this repository is staged in the customer's device tree.
TVFOCUS_RELEASE_ROOT := vendor/customer/tvfocus

PRODUCT_COPY_FILES += \
    $(TVFOCUS_RELEASE_ROOT)/jar/tvfocus-policy.jar:$(TARGET_COPY_OUT_SYSTEM)/framework/tvfocus-policy.jar \
    $(TVFOCUS_RELEASE_ROOT)/so/armeabi-v7a/libfocusjni.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libfocusjni.so \
    $(TVFOCUS_RELEASE_ROOT)/so/armeabi-v7a/libfocusx_free.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libfocusx_free.so \
    $(TVFOCUS_RELEASE_ROOT)/so/armeabi-v7a/libc++_shared.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libc++_shared.so \
    $(TVFOCUS_RELEASE_ROOT)/system/bin/uinputd:$(TARGET_COPY_OUT_SYSTEM)/bin/uinputd \
    $(TVFOCUS_RELEASE_ROOT)/system/usr/idc/unicorn-focus-touch.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/unicorn-focus-touch.idc \
    $(TVFOCUS_RELEASE_ROOT)/config/tvfocus-packages.txt:$(TARGET_COPY_OUT_SYSTEM)/etc/tvfocus-packages.txt \
    $(TVFOCUS_RELEASE_ROOT)/config/tvfocus-overrides.json:$(TARGET_COPY_OUT_SYSTEM)/etc/tvfocus-overrides.json \
    $(TVFOCUS_RELEASE_ROOT)/config/prefetch.list:$(TARGET_COPY_OUT_SYSTEM)/etc/unicorn/prefetch.list
