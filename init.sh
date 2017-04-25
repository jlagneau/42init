#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jlagneau <jlagneau@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/12/01 06:20:42 by jlagneau          #+#    #+#              #
#    Updated: 2017/04/25 19:11:52 by jlagneau         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

echo '\033[0;32m   __ __ ___   _       _ __ \033[0m'
echo '\033[0;32m  / // /|__ \ (_)___  (_) /_\033[0m'
echo '\033[0;32m / // /___/ // / __ \/ / __/\033[0m'
echo '\033[0;32m/__  __/ __// / / / / / /_  \033[0m'
echo '\033[0;32m  /_/ /____/_/_/ /_/_/\__/  \033[0m'
echo ''

#
# INIT
#

# get name of the project to init, replace spaces by underscore and use lower case
project_name="$(echo ${1//[- ]/_} | tr '[:upper:]' '[:lower:]')"
# get name of the project in upper case
project_name_uppercase="$(echo ${project_name} | tr '[:lower:]' '[:upper:]')"
# get the real path of the exec script
exec_dir=$(dirname `perl -e 'use Cwd "abs_path";print abs_path(shift)' $0`)
username=$(whoami)

#
# CHECK
#

# arg number not equal 1
if [[ "$#" -ne 1 ]]; then
    echo "Usage : `basename "$0"` [PROJECT_NAME]"
    exit 1
fi

if [[ -d "${project_name}" ]]; then
    echo "Directory [${project_name}] already exists."
    exit 1
fi

#
# RUN
#
echo "Creating project files... [\033[0;33m${1}\033[0m]"

mkdir -p "${project_name}" && cd $_

# Copy skeleton into directory and search and replace program name
env GLOBIGNORE=". .." cp -a ${exec_dir}/skel/* ${exec_dir}/skel/.* ./
find . -type f -exec perl -pi -e s,__PROJECT_NAME__,${project_name},g {} \;
find . -type f -exec perl -pi -e s,__PROJECT_NAME_UPPERCASE__,${project_name_uppercase},g {} \;
find . -type f -exec perl -pi -e s,__USERNAME__,${username},g {} \;
mv include/header_template.h include/${project_name}.h

# Create the "auteur" file if it doesn't exists
if [[ ! -e "auteur" ]]; then
    echo ${username} > auteur
fi

# Create a README.md file if it doesn't exists
if [[ ! -e "README.md" ]]; then
    echo "# ${1}" > README.md
    cat README.md.tpl >> README.md
    rm README.md.tmp
fi

# Initialize git and add libft
echo 'Initialize git repository...'
if [[ ! -e ".git" ]]; then
    git init --quiet .
fi
git checkout -B develop
git submodule --quiet add https://github.com/${username}/libft.git
git add -A .
git commit --quiet -m "[:rocket: 42init] Initial commit: Hello World"

echo 'Project ready !'
