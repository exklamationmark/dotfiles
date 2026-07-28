push-to-dotfiles:
	@[ "$(git branch --show-current)" = "dotfiles" ] || { echo "Error: must be on 'dotfiles' branch"; exit 1; }
	git reset $(git commit-tree HEAD^{tree} -m "feat: Bootstrap config")
	git push dotfiles dotfiles:main --force
