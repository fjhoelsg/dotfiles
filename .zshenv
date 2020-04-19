#!/bin/sh

# In MacOS, path helper reorders the PATH entries
if [ -x /usr/libexec/path_helper ]; then
  # Call path helper explictly to ensure system paths are included in PATH
	eval `/usr/libexec/path_helper -s`
  # Disable loading global configurations form this point forward
  setopt no_global_rcs
fi

source ~/.profile
