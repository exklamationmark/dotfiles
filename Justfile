clean-for-public:
	find . -type f \
		| grep -vE '^\./\.gitignore$' \
		| grep -vE '^\./\.git/' \
		| grep -vE '^\./home-manager/flake\.(nix|lock)$' \
		| grep -vE '^\./home-manager/\.gitignore$' \
		| grep -vE '^\./home-manager/home-manager/home\.nix$' \
		| grep -vE '^\./home-manager/home-manager/apps/git/' \
		| grep -vE '^\./home-manager/home-manager/apps/tmux/' \
		| grep -vE '^\./lib/public/' \
		| grep -vE '^\./(bootstrap|setup)\.bash$' \
		| grep -vE '^\./(Justfile|README\.md|LICENSE)$' \
		| xargs git rm -f --ignore-unmatch

push-to-dotfiles:
	@[ "$(git branch --show-current)" = "dotfiles" ] || { echo "Error: must be on 'dotfiles' branch"; exit 1; }
	git reset $(git commit-tree HEAD^{tree} -m "feat: Bootstrap config")
	git push dotfiles dotfiles:main --force

# Show favorite apps in the dock
show-dock-applications:
	echo "Put these into home-manager/home-manager/style/ubuntu/ubuntu.nix"
	dconf read /org/gnome/shell/favorite-apps
