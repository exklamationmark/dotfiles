.PHONY: all
all: configure

.PHONY: configure
configure:
	chown $(shell whoami) home-manager/home-manager/apps/personal/ssh/personal.config
	chown $(shell whoami) home-manager/home-manager/apps/work/ssh/work.config
	chmod 600 home-manager/home-manager/apps/personal/ssh/personal.config
	chmod 600 home-manager/home-manager/apps/work/ssh/work.config
	chmod 600 ~/.ssh/*.pub

.PHONY: show-dock-applications
show-dock-applications: ## Show favorite apps in the dock
	dconf read /org/gnome/shell/favorite-apps
