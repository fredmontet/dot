#add each <relation> folder to fpath so that they can add functions and completion scripts
for rel_folder ($DOT/rel/*) if [ -d $rel_folder ]; then  fpath=($rel_folder $fpath); fi;
