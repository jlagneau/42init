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

# Exec
CC        ?= gcc
RM         = rm -rf

# Directories
LIB_PATH   = libft/
LIBH_PATH  = libft/include/

SRCS_PATH  = src/
HEAD_PATH  = include/

OBJS_PATH  = .obj/
DEPS_PATH  = .dep/

# Flags
CFLAGS    += -Wall -Wextra -Werror
CPPFLAGS  += -I$(HEAD_PATH) -I$(LIBH_PATH)
LDFLAGS   += -L$(LIB_PATH)
DEPSFLAGS  = -MMD -MF"$(DEPS_PATH)$(notdir $(@:.o=.d))"

# Files
SRCS      := $(shell find src -type f)

OBJS       = $(addprefix $(OBJS_PATH), $(notdir $(SRCS:.c=.o)))
DEPS       = $(addprefix $(DEPS_PATH), $(notdir $(SRCS:.c=.d)))

DEB_OBJS   = $(OBJS:.o=_debug.o)
DEB_DEPS   = $(DEPS:.d=_debug.d)

#
# Rules
#

# Phony.
.PHONY: all clean fclean norme re redebug

# Link the main executable.
$(NAME): CFLAGS += -O3
$(NAME): LDFLAGS += -lft
$(NAME): $(OBJS)
	@-git submodule update --init --recursive
	@make -C $(LIB_PATH)
	$(CC) $^ $(LDFLAGS) -o $@

# Link the debug executable.
debug: CFLAGS += -g3
debug: LDFLAGS += -lft_debug
debug: $(DEB_OBJS)
	@-git submodule update --init --recursive
	@make -C $(LIB_PATH) debug
	$(CC) $^ $(LDFLAGS) -o $@

# Compile the objects.
$(OBJS_PATH)%.o: $(SRCS_PATH)%.c
	@mkdir -p $(OBJS_PATH) $(DEPS_PATH)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(DEPSFLAGS) -c $< -o $@

# Compile the debug objects.
$(OBJS_PATH)%_debug.o: $(SRCS_PATH)%.c
	@mkdir -p $(OBJS_PATH) $(DEPS_PATH)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(DEPSFLAGS) -c $< -o $@

# Make all.
all: $(NAME)

# Remove the objects and dependencies files.
clean:
	$(RM) $(OBJS_PATH) $(DEPS_PATH)
	@make -C $(LIB_PATH) clean

# Remove the object, dependencies and executables files.
fclean:
	$(RM) $(OBJS_PATH) $(DEPS_PATH)
	$(RM) $(NAME) $(DEB_NAME)
	@make -C $(LIB_PATH) fclean

# Clean and rebuild the executable.
re: fclean all

# Clean and rebuild the debug executable.
redebug: fclean debug

# Include dependencies for objects.
-include $(DEPS)
-include $(DEB_DEPS)
