ifneq ($(filter mpq8092 msm8960 msm8226 msm8x26 msm8610 msm8974 msm8x74 apq8084 msm8916 msm8994 msm8992 msm8909 msm8952,$(TARGET_BOARD_PLATFORM)),)
ifeq ($(TARGET_BOARD_PLATFORM),msm8952)
ifeq ($(call is-board-platform-in-list, msm8996),true)
    TARGET_USES_SDM = true
else
    TARGET_USES_SDM = false
endif

display-hals := libgralloc libcopybit liblight libmemtrack libqservice libqdutils
display-hals += hdmi_cec

ifeq ($(TARGET_USES_SDM), true)
    sdm-libs := sdm/libs
    display-hals += $(sdm-libs)/utils $(sdm-libs)/core $(sdm-libs)/hwc
else
    display-hals += libgenlock libhwcomposer liboverlay libhdmi
endif

ifeq ($(call is-vendor-board-platform,QCOM),true)
    include $(call all-named-subdir-makefiles,$(display-hals))
else
ifneq ($(filter msm% apq%,$(TARGET_BOARD_PLATFORM)),)
    include $(call all-named-subdir-makefiles,$(display-hals))
endif
endif
endif
endif
