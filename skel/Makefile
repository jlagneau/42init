#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jlagneau <jlagneau@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2013/11/21 08:29:58 by jlagneau          #+#    #+#              #
#    Updated: 2015/12/03 07:55:04 by jlagneau         ###   ########.fr        #
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
LIB       = libft/

SRCS_PATH = src/
HEAD_PATH = include/

OBJS_PATH = .obj/
DEPS_PATH = .dep/

# Exec
CC        = gcc
RM        = rm

# Flags
IFLAGS    = -I$(HEAD_PATH) -I$(LIB)$(HEAD_PATH)
CFLAGS    = -Wall -Wextra -Werror -pedantic
LDFLAGS   = -L$(LIB)
DEPSFLAGS = -MMD -MF"$(DEPS_PATH)$(notdir $(@:.o=.d))"
RMFLAGS   = -rf

# Files
SRCS     := $(shell find src -type f)
DEPS      = $(addprefix $(DEPS_PATH), $(notdir $(SRCS:.c=.d)))
OBJS      = $(addprefix $(OBJS_PATH), $(notdir $(SRCS:.c=.o)))
DEB_OBJS  = $(OBJS:.o=_debug.o)
DEB_DEPS  = $(DEB_OBJS:.o=.d)

# Print informations about the project
$(info :: Project: $(NAME))
ifneq (, $(strip $(ISGIT)))
    $(info :: Version : $(VER))
    $(info :: Last modifications : $(GDATE))
endif

# Rules
$(NAME): CFLAGS += -O3
$(NAME): LDFLAGS += -lft
$(NAME): $(OBJS)
	@make -C $(LIB)
	$(CC) $^ $(LDFLAGS) -o $@

debug: CFLAGS += -g3
debug: LDFLAGS += -lft_debug
debug: $(DEB_OBJS)
	@make -C $(LIB) debug
	$(CC) $^ $(LDFLAGS) -o $@

$(OBJS_PATH)%.o: $(SRCS_PATH)%.c
	@mkdir -p $(OBJS_PATH)
	@mkdir -p $(DEPS_PATH)
	$(CC) $(IFLAGS) $(CFLAGS) $(DEPSFLAGS) -c $< -o $@

$(OBJS_PATH)%_debug.o: $(SRCS_PATH)%.c
	@mkdir -p $(OBJS_PATH)
	@mkdir -p $(DEPS_PATH)
	$(CC) $(IFLAGS) $(CFLAGS) $(DEPSFLAGS) -c $< -o $@

norme:
	@norminette ./**/*.{h,c}

all: $(NAME)

clean:
	$(RM) $(RMFLAGS) $(OBJS_PATH) $(DEPS_PATH)
	@make -C $(LIB) clean

fclean:
	$(RM) $(RMFLAGS) $(OBJS_PATH) $(DEPS_PATH)
	$(RM) $(RMFLAGS) $(NAME) $(DEB_NAME)
	@make -C $(LIB) fclean

re: fclean all

redebug: fclean debug

-include $(DEPS)
-include $(DEB_DEPS)

.PHONY: all clean fclean norme re redebug
