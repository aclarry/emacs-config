#!/usr/bin/env python
"""Installs emacs configuration in ~/.emacs and ~/.emacs.d/settings/

Author: Andrew Clarry

Run with command "install" to update emacs configuration through .emacs and 
.emacs.d/settings/* files.

Run with command "update" to update backup files
"""

import sys
import os
import shutil

home_dir = os.path.expanduser("~")
emacs_file = os.path.join(home_dir, ".emacs")
settings_dir = os.path.join(home_dir, ".emacs.d", "settings")

backup_dir = os.path.join(os.path.dirname(os.path.realpath(__file__)), "backup")
emacs_backup = os.path.join(backup_dir, ".emacs")
settings_backup = os.path.join(backup_dir, "settings")

def update():
    """Updates the backup copy of emacs configurations"""
    if os.path.exists(backup_dir):
        shutil.rmtree(backup_dir)

    os.makedirs(backup_dir)
    
    shutil.copyfile(emacs_file, emacs_backup)
    shutil.copytree(settings_dir, settings_backup)


def install():
    """Installs the emacs configuration in the correct place"""

    if os.path.exists(emacs_file):
        print("\nWarning: Emacs configuration file %s already exists.\nOverwrite? [y/n]" % emacs_file)
        while True:
            if sys.version_info.major >= 3:
                choice = input().lower()
            else:
                choice = raw_input().lower()
            if choice in ("yes", "ye", "y"):
                break
            elif choice in ("no", "n"):
                print("Consider backing up emacs configuration file.")
                print("Exiting.")
                return
            else:
                print("Must answer yes or no. Overwrite emacs configuration file %s?" % settings_dir)

    if os.path.exists(settings_dir):
        print("\nWarning: Settings install directory %s already exists.\nOverwrite? [y/n]" % settings_dir)
        while True:
            if sys.version_info.major >= 3:
                choice = input().lower()
            else:
                choice = raw_input().lower()
            if choice in ("yes", "ye", "y"):
                break
            elif choice in ("no", "n"):
                return
            else:
                print("Must answer yes or no. Overwrite directory %s?" % settings_dir)

    shutil.rmtree(settings_dir)
    shutil.copyfile(emacs_backup, emacs_file)
    shutil.copytree(settings_backup, settings_dir)


if __name__ == "__main__":
    for arg in sys.argv:
        try:
            if arg == "install":
                install()
            elif arg == "update":
                update()
        except KeyboardInterrupt:
            print("Exiting")
            sys.exit(1)



    
