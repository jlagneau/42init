#!/usr/bin/env zsh

#
# CHECK
#

# arg number not equal 1
if [[ "$#" -ne 1 ]]; then
	echo "Usage : $_ [PROJECT_NAME]"
	exit 1
fi

# arg is already an existing file
if [[ -e "$1" ]]; then
	echo "Cannot create directory " ${project_name} ". A file with this name already exists."
	exit 1
fi

#
# INIT
#

# get name of the project to init
project_name=$1
# get the real path of the exec script
exec_dir=$(dirname `perl -e 'use Cwd "abs_path";print abs_path(shift)' $0`)

#
# RUN
#

echo '\033[0;32mCreating project files...\033[0m'

# Create directory
mkdir ${project_name}

# Move into directory
pushd ${project_name}

# Copy skeleton into directory and search and replace program name
env GLOBIGNORE=". .." cp -a ${exec_dir}/skel/* ${exec_dir}/skel/.* ./
`perl -pi -e s,__PROJECT_NAME__,${project_name},g ./**/*(.)`

# Create the auteur file
echo `whoami` > auteur

# Create a README.md file
echo "# "${project_name} > README.md

# Initialize git and add libft
git init --quiet .
git submodule --quiet add https://github.com/`whoami`/libft.git
git add -A .
git commit --quiet -m "Initial commit"

# Return to previous directory
popd
