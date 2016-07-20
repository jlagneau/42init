#!/usr/bin/env zsh
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jlagneau <jlagneau@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/12/01 06:20:42 by jlagneau          #+#    #+#              #
#    Updated: 2016/07/20 03:22:08 by jlagneau         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

echo '\033[0;32m   __ __ ___   _       _ __ \033[0m'
echo '\033[0;32m  / // /|__ \ (_)___  (_) /_\033[0m'
echo '\033[0;32m / // /___/ // / __ \/ / __/\033[0m'
echo '\033[0;32m/__  __/ __// / / / / / /_  \033[0m'
echo '\033[0;32m  /_/ /____/_/_/ /_/_/\__/  \033[0m'
echo ''

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
    echo "Cannot create directory $1."
    echo "A file with this name already exists."
    exit 1
fi

#
# INIT
#

# get name of the project to init
project_name=$1
project_name_uppercase="$(echo "$1" | tr '[:lower:]' '[:upper:]')"
# get the real path of the exec script
exec_dir=$(dirname `perl -e 'use Cwd "abs_path";print abs_path(shift)' $0`)

#
# RUN
#

echo 'Creating project files... [\033[0;33m'${project_name}'\033[0m]'

# Create directory
mkdir ${project_name}

# Move into directory
pushd ${project_name}

# Copy skeleton into directory and search and replace program name
env GLOBIGNORE=". .." cp -a ${exec_dir}/skel/* ${exec_dir}/skel/.* ./
find . -type f -exec perl -pi -e s,__PROJECT_NAME__,${project_name},g {} \;
find . -type f -exec perl -pi -e s,__PROJECT_NAME_UPPERCASE__,${project_name_uppercase},g {} \;
mv include/header_template.h include/${project_name}.h

# Create the auteur file
echo `whoami` > auteur

# Create include file
mkdir -p include
touch include/${project_name}.h

# Create a README.md file
echo "# "${project_name} > README.md

# Initialize git and add libft
echo 'Initialize git repository...'
git init --quiet .
git submodule --quiet add https://github.com/`whoami`/libft.git
git add -A .
git commit --quiet -m "[42init] Initial commit: Hello World"

# Return to previous directory
popd

echo 'Project ready !'
