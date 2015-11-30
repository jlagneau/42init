#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jlagneau <jlagneau@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2013/11/21 08:29:58 by jlagneau          #+#    #+#              #
#    Updated: 2015/11/30 15:25:01 by jlagneau         ###   ########.fr        #
#                                                                              #
#******************************************************************************#

# Variables
NAME      = PROJECT_NAME
DEB_NAME  = debug_PROJECT_NAME

ISGIT     := $(shell find . -name ".git" -type d)
HASTAGS   := $(shell git tag)

ifneq (, $(strip $(ISGIT)))
ifneq (, $(strip $(HASTAGS)))
	VER   := $(shell git describe --tags `git rev-list --tags --max-count=1`)
endif
	GDATE := $(shell git show -s --format="%ci" HEAD)
endif

LIB       = libft/

OBJS_PATH = bin/
SRCS_PATH = src/
HEAD_PATH = include/

CC        = gcc
CFLAGS    = -I$(HEAD_PATH) -I$(LIB)$(HEAD_PATH) -Wall -Wextra -Werror
LDFLAGS   = -L$(LIB)

RM        = rm
RMFLAGS   = -rf

# Sources files
SRCS      = src/main.c
OBJS      = $(addprefix $(OBJS_PATH), $(notdir $(SRCS:.c=.o)))
DEB_OBJS  = $(addprefix $(OBJS_PATH), $(notdir $(SRCS:.c=_debug.o)))

# Print informations about the library
$(info :: Project: $(NAME))
ifneq (, $(strip $(ISGIT)))
ifneq (, $(strip $(HASTAGS)))
    $(info :: Version : $(VER))
endif
    $(info :: Last modifications : $(GDATE))
endif

# Rules
$(NAME): CFLAGS += -g3
$(NAME): LDFLAGS += -lft
$(NAME): $(OBJS)
	make -C $(LIB)
	printf "[\033[36m%20s\033[0m] Linking and indexing" $(NAME)
	$(CC) $^ $(LDFLAGS) -o $@
	printf " [\033[32mDONE\033[0m]\n"

$(DEB_NAME): $(DEB_OBJS)
	make -C $(LIB) debug
	printf "[\033[36m%20s\033[0m] Linking and indexing" $(DEB_NAME)
	$(CC) $^ $(LDFLAGS) -o $@
	printf " [\033[32mDONE\033[0m]\n"

$(OBJS_PATH)%.o: $(SRCS_PATH)%.c
	if [ ! -d $(OBJS_PATH) ]; then \
	mkdir -p $(OBJS_PATH); \
	printf "[\033[36m%20s\033[0m] Compiling objects" $(NAME); \
	printf "    [\033[32mDONE\033[0m]\n"; \
	fi;
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJS_PATH)%_debug.o: $(SRCS_PATH)%.c
	if [ ! -d $(OBJS_PATH) ]; then \
	mkdir -p $(OBJS_PATH); \
	printf "[\033[36m%20s\033[0m] Compiling objects" $(NAME); \
	printf "    [\033[32mDONE\033[0m]\n"; \
	fi;
	$(CC) $(CFLAGS) -c $< -o $@

debug: CFLAGS += -g3
debug: LDFLAGS += -lft_debug
debug: $(DEB_NAME)

redebug: fclean debug

norme:
	norminette ./**/*.{h,c}

all: $(NAME)

clean:
	printf "[\033[36m%20s\033[0m] Removing objects" $(NAME)
	$(RM) $(RMFLAGS) $(OBJS_PATH)
	printf "     [\033[32mDONE\033[0m]\n"
	make -C $(LIB) clean

fclean:
	printf "[\033[36m%20s\033[0m] Removing objects" $(NAME)
	$(RM) $(RMFLAGS) $(OBJS_PATH)
	printf "     [\033[32mDONE\033[0m]\n"
	printf "[\033[36m%20s\033[0m] Removing binary" $(NAME)
	$(RM) $(RMFLAGS) $(NAME) $(DEB_NAME)
	printf "      [\033[32mDONE\033[0m]\n"
	make -C $(LIB) fclean

re: fclean all

.PHONY: all clean debug fclean lib lib_debug norme re redebug

.SILENT:
