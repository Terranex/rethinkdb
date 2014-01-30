# Copyright 2010-2013 RethinkDB, all rights reserved.

# There are three ways to override the default settings:
#  - custom.mk
#  - config.mk (generated by ./configure)

##### Settings local to this repository

CUSTOM ?= $(TOP)/custom.mk
$(eval $(value check-env-start))
  -include $(CUSTOM)
$(eval $(value check-env-check))

##### Detect configuration

# Include the config.mk file generated by ./configure
CONFIG ?= $(TOP)/config.mk
MAKECMDGOALS ?=
-include $(CONFIG)

ifneq (success,$(CONFIGURE_STATUS))
  CONFIGURE_ERROR ?= Missing or invalid config file.
  $(warning Configure error: $(CONFIGURE_ERROR))
  $(error Run ./configure or edit $(CONFIG))
endif

CONFIGURE_MAGIC_NUMBER ?=
ifneq (2,$(CONFIGURE_MAGIC_NUMBER))
  $(error The build system has changed. Please re-run ./configure $(CONFIGURE_COMMAND_LINE))
endif

include $(TOP)/mk/defaults.mk
