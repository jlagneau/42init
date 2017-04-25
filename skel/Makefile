#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jlagneau <jlagneau@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2013/11/21 08:29:58 by jlagneau          #+#    #+#              #
#    Updated: 2017/04/08 10:47:14 by jlagneau         ###   ########.fr        #
#                                                                              #
#******************************************************************************#

#
# Variables
#

# Name of the executable
NAME       = __PROJECT_NAME__
DEB_NAME   = __PROJECT_NAME___debug

# Exec
CC        ?= gcc
RM         = rm -rf

# Directories
LIBFT_PATH = libft

SRCS_PATH  = src
OBJS_PATH  = build/obj
DEPS_PATH  = build/dep

HEADERS    = include $(LIBFT_PATH)/include

# Flags
CFLAGS    ?= -Wall -Wextra -Werror
CPPFLAGS  += $(addprefix -I, $(HEADERS))
LDFLAGS   += -L$(LIBFT_PATH)
DEPSFLAGS  = -MMD -MF"$(subst $(OBJS_PATH),$(DEPS_PATH),$(@:.o=.d))"

# Files
SRCS      := $(shell find src -type f)
SRCS_SUB  := $(subst $(SRCS_PATH),, $(shell find src -mindepth 1 -type d))

OBJS      := $(subst $(SRCS_PATH), $(OBJS_PATH), $(SRCS:.c=.o))
DEPS      := $(subst $(SRCS_PATH), $(DEPS_PATH), $(SRCS:.c=.d))

DEB_OBJS  := $(OBJS:.o=_debug.o)
DEB_DEPS  := $(DEPS:.d=_debug.d)

#
# Macro
#

define CREATE_BUILD_DIR
@mkdir -p $(OBJS_PATH) $(addprefix $(OBJS_PATH), $(SRCS_SUB))
@mkdir -p $(DEPS_PATH) $(addprefix $(DEPS_PATH), $(SRCS_SUB))
endef

define COMPILE
$(CREATE_BUILD_DIR)
$(CC) $(CFLAGS) $(CPPFLAGS) $(DEPSFLAGS) -c $< -o $@
endef

define MAKELIB
@-git submodule update --init --recursive
@make -C $(LIBFT_PATH) $(1)
endef

define LINK
$(CC) $^ $(LDFLAGS) -o $@
endef

#
# Rules
#

# Phony.
.PHONY: all clean debug fclean re redebug

# Link the main executable.
$(NAME): CFLAGS += -O3
$(NAME): LDFLAGS += -lft
$(NAME): $(OBJS)
	$(MAKELIB)
	$(LINK)

# Link the debug executable.
$(DEB_NAME): CFLAGS += -g3
$(DEB_NAME): LDFLAGS += -lft_debug
$(DEB_NAME): $(DEB_OBJS)
	$(call MAKELIB, debug)
	$(LINK)

# Compile the objects.
$(OBJS_PATH)%.o: $(SRCS_PATH)%.c
	$(COMPILE)

# Compile the debug objects.
$(OBJS_PATH)%_debug.o: $(SRCS_PATH)%.c
	$(COMPILE)

# Make all.
all: $(NAME)

# Make debug
debug: $(DEB_NAME)

# Remove the objects and dependencies files.
clean:
	$(call MAKELIB, clean)
	$(RM) build

# Remove the object, dependencies and executables files.
fclean:
	$(call MAKELIB, fclean)
	$(RM) build $(NAME) $(DEB_NAME)

# Clean and rebuild the executable.
re: fclean all

# Clean and rebuild the debug executable.
redebug: fclean debug

# Include dependencies for objects.
-include $(DEPS)
-include $(DEB_DEPS)
