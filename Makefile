.PHONY: show-dock-applications
show-dock-applications: ## Show favorite apps in the dock
	dconf read /org/gnome/shell/favorite-apps
