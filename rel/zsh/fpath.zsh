#add each <relation> folder to fpath so that they can add functions and completion scripts
for rel_folder ($DOT/rel/*) if [ -d $rel_folder ]; then  fpath=($rel_folder $fpath); fi;

# user completion functions (poetry, rustup, … drop files here). Added before
# compinit runs in zshrc so a single compinit picks them up.
[ -d ~/.zfunc ] && fpath=(~/.zfunc $fpath)
