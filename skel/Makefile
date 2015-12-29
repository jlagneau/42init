#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jlagneau <jlagneau@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2013/11/21 08:29:58 by jlagneau          #+#    #+#              #
#    Updated: 2015/12/04 08:46:16 by jlagneau         ###   ########.fr        #
#                                                                              #
#******************************************************************************#

# Variables
NAME      = __PROJECT_NAME__

# Information variables
ISGIT     := $(shell find . -name ".git" -type d)
HASTAGS   := $(shell git tag)

ifneq (, $(strip $(ISGIT)))
ifneq (, $(strip $(HASTAGS)))
VER      := $(shell git describe --tags `git rev-list --tags --max-count=1`)
else
VER      := $(shell git rev-parse --short HEAD)
endif
GDATE    := $(shell git show -s --format="%ci" HEAD)
endif

# Directories
LIB_PATH  = libft/
LIBH_PATH = libft/include/

SRCS_PATH = src/
HEAD_PATH = include/

OBJS_PATH = .obj/
DEPS_PATH = .dep/

# Exec
CC        = gcc
RM        = rm -rf

# Flags
CFLAGS    = -Wall -Wextra -Werror -pedantic
CPPFLAGS  = -I$(HEAD_PATH) -I$(LIBH_PATH)
LDFLAGS   = -L$(LIB_PATH)
LDLIBS    =
DEPSFLAGS = -MMD -MF"$(DEPS_PATH)$(notdir $(@:.o=.d))"

# Files
SRCS     := $(shell find src -type f)

DEPS      = $(addprefix $(DEPS_PATH), $(notdir $(SRCS:.c=.d)))
OBJS      = $(addprefix $(OBJS_PATH), $(notdir $(SRCS:.c=.o)))

DEB_OBJS  = $(OBJS:.o=_debug.o)
DEB_DEPS  = $(addprefix $(DEPS_PATH), $(notdir $(DEB_OBJS:.o=.d)))

# Print informations about the project
$(info :: Project: $(NAME))
ifneq (, $(strip $(ISGIT)))
    $(info :: Version : $(VER))
    $(info :: Last modifications : $(GDATE))
endif

# Phony
.PHONY: all clean fclean norme re redebug

# Rules
$(NAME): CFLAGS += -O3
$(NAME): LDLIBS += -lft
$(NAME): $(OBJS)
	@-git submodule update --init --recursive
	@make -C $(LIB_PATH)
	$(CC) $^ $(LDFLAGS) $(LDLIBS) -o $@

debug: CFLAGS += -g3
debug: LDLIBS += -lft_debug
debug: $(DEB_OBJS)
	@-git submodule update --init --recursive
	@make -C $(LIB_PATH) debug
	$(CC) $^ $(LDFLAGS) $(LDLIBS) -o $@

$(OBJS_PATH)%.o: $(SRCS_PATH)%.c
	@mkdir -p $(OBJS_PATH) $(DEPS_PATH)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(DEPSFLAGS) -c $< -o $@

$(OBJS_PATH)%_debug.o: $(SRCS_PATH)%.c
	@mkdir -p $(OBJS_PATH) $(DEPS_PATH)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(DEPSFLAGS) -c $< -o $@

norme:
	@norminette ./**/*.{h,c}

all: $(NAME)

clean:
	$(RM) $(OBJS_PATH) $(DEPS_PATH)
	@make -C $(LIB_PATH) clean

fclean:
	$(RM) $(OBJS_PATH) $(DEPS_PATH)
	$(RM) $(NAME) $(DEB_NAME)
	@make -C $(LIB_PATH) fclean

re: fclean all

redebug: fclean debug

-include $(DEPS)
-include $(DEB_DEPS)
