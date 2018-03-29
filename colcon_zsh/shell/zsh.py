# Copyright 2016-2018 Dirk Thomas
# Licensed under the Apache License, Version 2.0

from pathlib import Path
import sys

from colcon_core.plugin_system import satisfies_version
from colcon_core.plugin_system import SkipExtensionException
from colcon_core.shell import logger
from colcon_core.shell import ShellExtensionPoint
from colcon_core.shell import use_all_shell_extensions
from colcon_core.shell.template import expand_template


class ZShell(ShellExtensionPoint):
    """Generate `.zsh` scripts to extend the environment."""

    def __init__(self):  # noqa: D107
        super().__init__()
        satisfies_version(ShellExtensionPoint.EXTENSION_POINT_VERSION, '^1.0')
        if sys.platform == 'win32' and not use_all_shell_extensions:
            raise SkipExtensionException('Not used on Windows systems')

    def create_prefix_script(
        self, prefix_path, pkg_names, merge_install
    ):  # noqa: D102
        prefix_env_path = prefix_path / 'prefix.zsh'
        logger.info(
            "Creating prefix script '{prefix_env_path}'".format_map(locals()))
        expand_template(
            Path(__file__).parent / 'template' / 'prefix.zsh.em',
            prefix_env_path,
            {
                'pkg_names': pkg_names,
                'merge_install': merge_install,
            })

    def create_package_script(
        self, prefix_path, pkg_name, hooks
    ):  # noqa: D102
        pkg_env_path = prefix_path / 'share' / pkg_name / 'package.zsh'
        logger.info(
            "Creating package script '{pkg_env_path}'".format_map(locals()))
        expand_template(
            Path(__file__).parent / 'template' / 'package.zsh.em',
            pkg_env_path,
            {
                'pkg_name': pkg_name,
                'hooks': list(filter(
                    lambda hook: str(hook[0]).endswith('.zsh'), hooks))
            })
