# generated from colcon_zsh/shell/template/prefix.zsh.em
@[if pkg_names]@

# function to source another script with conditional trace output
# first argument: the name of the script file
colcon_prefix_source_zsh_script() {
  # arguments
  _colcon_prefix_source_zsh_script="$1"

  # source script with conditional trace output
  if [ -f "$_colcon_prefix_source_zsh_script" ]; then
    if [ -n "$COLCON_TRACE" ]; then
      echo ". \"$_colcon_prefix_source_zsh_script\""
    fi
    . "$_colcon_prefix_source_zsh_script"
  else
    if [ -n "$COLCON_TRACE" ]; then
      echo "not found: \"$_colcon_prefix_source_zsh_script\""
    fi
  fi

  unset _colcon_prefix_source_zsh_script
}


@[end if]@
@[for i, pkg_name in enumerate(pkg_names)]@
@[  if i == 0]@
# a zsh script is able to determine its own path
@[  end if]@
COLCON_CURRENT_PREFIX=$(builtin cd -q "`dirname "${(%):-%N}"`@('' if merge_install else ('/' + pkg_name))" > /dev/null && pwd)
colcon_prefix_source_zsh_script "$COLCON_CURRENT_PREFIX/share/@(pkg_name)/package.zsh"

@[end for]@
@[if pkg_names]@
unset COLCON_CURRENT_PREFIX
unset colcon_prefix_source_zsh_script
@[end if]@
