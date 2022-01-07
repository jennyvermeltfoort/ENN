ifeq ($(CC)),)
CC := gcc
endif
ifeq ($(ENN_ROOT),)
ENN_ROOT := ./
endif

ENN_SRC_DIR := $(ENN_ROOT)/src
ENN_BUILD_DIR := $(ENN_ROOT)/build
ENN_OBJ_DIR := $(ENN_BUILD_DIR)/obj
ENN_BIN_DIR := $(ENN_BUILD_DIR)/bin
ENN_MAKEFILE := $(shell find $(ENN_SRC_DIR) -name Makefile)

ENN_CPPFLAGS := -MMD -MP
ENN_CFLAGS   := -Wall
ENN_LDFLAGS  :=
ENN_LDLIBS   := -lm

$(foreach makefile,$(ENN_MAKEFILE), \
	$(eval include $(makefile)) \
	$(eval ENN_OBJS += $(foreach obj,$(ENN_OBJ), \
		$(patsubst $(ENN_SRC_DIR)%, $(ENN_OBJ_DIR)%, $(dir $(makefile))$(obj)))) \
	$(eval ENN_APIS += $(foreach api,$(ENN_API),-I$(dir $(makefile))$(api))) \
	$(eval ENN_OBJ := ) \
	$(eval ENN_API := ))

ENN_FLAGS := $(ENN_APIS) $(ENN_LDFLAGS) $(ENN_OBJS) $(ENN_LDLIBS)

.PHONY: enn_clean enn_build

$(ENN_OBJ_DIR)/%.o: $(ENN_SRC_DIR)/%.c
	@mkdir -p $(@D)
	$(CC) $(ENN_APIS) $(ENN_CPPFLAGS) $(ENN_CFLAGS) -c $< -o $@

enn_clean:
	@$(RM) -rv $(ENN_BUILD_DIR)

enn_build: $(ENN_OBJS)

-include $(ENN_OBJ:.o=.d)