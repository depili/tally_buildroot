#############################################################
#
# E2 Tally
#
#############################################################
E2TALLY_VERSION = 1.5
E2TALLY_SITE_METHOD = local
E2TALLY_SITE = $(TOPDIR)/package/e2tally

define E2TALLY_BUILD_CMDS
     GOPATH=$(@D) GOARCH=arm GOOS=linux GOARM=7 go get -u github.com/depili/e2/cmd/tally/
endef

define E2TALLY_INSTALL_TARGET_CMDS
     $(INSTALL) -D -m 0755 $(@D)/bin/linux_arm/tally $(TARGET_DIR)/root/tally
     $(INSTALL) -D -m 0755 $(@D)/S30copy_files $(TARGET_DIR)/etc/init.d/S30copy_files
     $(INSTALL) -D -m 0755 $(@D)/S90tally $(TARGET_DIR)/etc/init.d/S90tally
     $(INSTALL) -D -m 0755 $(@D)/tally_pokemon.sh $(TARGET_DIR)/root/tally_pokemon.sh
endef

$(eval $(generic-package))
