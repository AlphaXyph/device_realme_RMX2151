#
# Copyright (C) 2020 Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/realme/RMX2151

# Parts
$(call inherit-product-if-exists, packages/apps/RealmeParts/parts.mk)

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Call proprietary blob setup
$(call inherit-product, vendor/realme/RMX2151/RMX2151-vendor.mk)

# Parts
$(call inherit-product-if-exists, packages/apps/RealmeParts/parts.mk)

# RealmeDirac
$(call inherit-product-if-exists, packages/apps/RealmeDirac/dirac.mk)

# VNDK
PRODUCT_SHIPPING_API_LEVEL := 29
PRODUCT_EXTRA_VNDK_VERSIONS := 30

# Dynamic Partition
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    android.hardware.bluetooth.a2dp@1.0-impl \
    android.hardware.bluetooth.a2dp@1.0-service \
    GoogleCameraGo

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/etc/audio_policy_configuration.xml \
    $(DEVICE_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_ODM)/etc/audio_policy_configuration.xml

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/enginedefault/config/example/phone/audio_policy_engine_configuration.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_TARGET_VNDK_VERSION)/etc/audio_policy_engine_configuration.xml \
    frameworks/av/services/audiopolicy/enginedefault/config/example/phone/audio_policy_engine_default_stream_volumes.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_TARGET_VNDK_VERSION)/etc/audio_policy_engine_default_stream_volumes.xml \
    frameworks/av/services/audiopolicy/enginedefault/config/example/phone/audio_policy_engine_product_strategies.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_TARGET_VNDK_VERSION)/etc/audio_policy_engine_product_strategies.xml \
    frameworks/av/services/audiopolicy/enginedefault/config/example/phone/audio_policy_engine_stream_volumes.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_TARGET_VNDK_VERSION)/etc/audio_policy_engine_stream_volumes.xml

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/etc/audio_policy_configuration.xml

# Bluetooth
PRODUCT_PACKAGES += \
    libldacBT_dec

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/etc/fstab.mt6785:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6785

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1-service.RMX2151 \
    vendor.oppo.hardware.biometrics.fingerprint@2.1

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.fingerprint.xml

# Google Photos
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/pixel_2016_exclusive.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/pixel_2016_exclusive.xml

# HIDL
PRODUCT_PACKAGES += \
    libhidltransport \
    libhwbinder

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/vendor_override_manifest.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS)/etc/vintf/manifest/vendor_override_manifest.xml

# Init
PRODUCT_PACKAGES += \
    init.mt6785.rc \
    fstab.mt6785 \
    fstab.enableswap \
    perf_profile.sh

# Keylayouts
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/idc/mtk-kpd.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/mtk-kpd.idc \
    $(DEVICE_PATH)/keylayout/mtk-kpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-kpd.kl \
    $(DEVICE_PATH)/keylayout/touchpanel.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/touchpanel.kl

# KPOC
PRODUCT_PACKAGES += \
    libsuspend \
    android.hardware.health@2.0

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.RMX2151

# NFC
PRODUCT_PACKAGES += \
    com.android.nfc_extras \
    NfcNci \
    SecureElement \
    Tag \
    android.hardware.nfc@1.2-service

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay

# Permissions
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/permissions/privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-mediatek.xml \
    $(DEVICE_PATH)/permissions/privapp-permissions-hotword.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-hotword.xml \
    $(DEVICE_PATH)/permissions/privapp-permissions-hotword.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-hotword.xml \
    $(DEVICE_PATH)/permissions/privapp-permissions-RMX2151.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-RMX2151.xml \
    $(DEVICE_PATH)/permissions/privapp-permissions-RMX2151.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-RMX2151.xml

# Power
PRODUCT_PACKAGES += \
    power.mt6785

# Properties
-include $(DEVICE_PATH)/system_prop.mk
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

# Protobuf
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full-vendorcompat \
    libprotobuf-cpp-lite-vendorcompat

# Public Libraries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt

# RcsService
PRODUCT_PACKAGES += \
    RcsService

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)


# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0 \
    android.hardware.usb@1.0.vendor \
    android.hardware.usb@1.1 \
    android.hardware.usb@1.1.vendor

# Symbols
PRODUCT_PACKAGES += \
    libshim_showlogo

# Vendor overlay
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(DEVICE_PATH)/vendor-overlay/,$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_EXTRA_VNDK_VERSIONS))

# Wi-Fi
PRODUCT_PACKAGES += \
    TetheringConfigOverlay \
    WifiOverlay

