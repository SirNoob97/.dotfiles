# NVM
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# SDKMAN
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && . "$SDKMAN_DIR/bin/sdkman-init.sh"


# MINICONDA
[ -s "$MINICONDA_DIR/bin/conda" ] && $MINICONDA_DIR/bin/conda shell.bash hook &> /dev/null
[ -f "$MINICONDA_DIR/etc/profile.d/conda.sh" ] && . "$MINICONDA_DIR/etc/profile.d/conda.sh"
