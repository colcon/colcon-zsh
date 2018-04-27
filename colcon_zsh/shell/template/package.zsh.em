# generated from colcon_zsh/shell/template/package.zsh.em

# This script extends the environment for this package.

# a zsh script is able to determine its own path if necessary
if [ -z "$COLCON_CURRENT_PREFIX" ]; then
  # the prefix is two levels up from the package specific share directory
  _colcon_package_zsh_COLCON_CURRENT_PREFIX="$(builtin cd -q "`dirname "${(%):-%N}"`/../.." > /dev/null && pwd)"
else
  _colcon_package_zsh_COLCON_CURRENT_PREFIX="$COLCON_CURRENT_PREFIX"
fi

# function to source another script with conditional trace output
# first argument: the path of the script
# additional arguments: arguments to the script
_colcon_package_zsh_source_script() {
  if [ -f "$1" ]; then
    if [ -n "$COLCON_TRACE" ]; then
      echo ". \"$1\""
    fi
    . $@@
  else
    echo "not found: \"$1\"" 1>&2
  fi
}

# source sh script of this package
_colcon_package_zsh_source_script "$_colcon_package_zsh_COLCON_CURRENT_PREFIX/share/@(pkg_name)/package.sh"
@[if hooks]@

# setting COLCON_CURRENT_PREFIX avoids determining the prefix in the sourced scripts
COLCON_CURRENT_PREFIX="$_colcon_package_zsh_COLCON_CURRENT_PREFIX"

# source zsh hooks
@[  for hook in hooks]@
_colcon_package_zsh_source_script "$COLCON_CURRENT_PREFIX/@(hook[0])"@
@[    for hook_arg in hook[1]]@
 @(hook_arg)@
@[    end for]
@[  end for]@

unset COLCON_CURRENT_PREFIX
@[end if]@

unset _colcon_package_zsh_source_script
unset _colcon_package_zsh_COLCON_CURRENT_PREFIX
