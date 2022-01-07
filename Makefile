CC := gcc
AR := ar

SRC_DIR := src
BUILD_DIR := build
OBJ_DIR := $(BUILD_DIR)/obj
TMP_DIR := $(BUILD_DIR)/tmp
BIN_DIR := $(BUILD_DIR)/bin
LIB_DIR := $(BUILD_DIR)/lib
LIB_API_DIR := $(LIB_DIR)/api

LIB := $(LIB_DIR)/libenn.a
MAKEFILE := $(shell find $(SRC_DIR) -name Makefile)

$(foreach makefile,$(MAKEFILE), \
	$(eval include $(makefile)) \
	$(eval _UNIT_OBJ += $(foreach obj,$(UNIT_OBJ), \
		$(patsubst $(SRC_DIR)%, $(OBJ_DIR)%, $(dir $(makefile))$(obj)))) \
	$(eval _UNIT_API += $(foreach api,$(UNIT_API),$(dir $(makefile))$(api))) \
	$(eval _OBJ_DIRS += $(dir $(makefile))) \
	$(eval UNIT_OBJ := ) \
	$(eval UNIT_API := ))

CC_FLAGS := -MMD -MP -Wall
CC_OBJECTS := $(_UNIT_OBJ)
CC_INCLUDES := $(patsubst %, -I%, $(_UNIT_API))
SRC_API_HEADERS := $(shell find $(_UNIT_API) -name *.h)
LIB_API_HEADERS := $(patsubst $(SRC_DIR)/%.h, $(OBJ_DIR)/%.h, $(SRC_API_HEADERS))

.PHONY: all clean

$(LIB_API_DIR):
	@mkdir -p $@

$(LIB_DIR):
	@mkdir -p $@

$(OBJ_DIR)/%.h: $(SRC_DIR)/%.h | $(LIB_API_DIR)
	@mkdir -p $(@D)
	touch $@
	cp -n $< $(LIB_API_DIR)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(@D)
	$(CC) $(CC_INCLUDES) $(CC_FLAGS) $(CFLAGS) -c $< -o $@

$(LIB): $(CC_OBJECTS) | $(LIB_API_HEADERS) $(LIB_DIR) 
	$(AR) rcs $(LIB) $<

all: $(LIB)

clean:
	@$(RM) -rv $(BUILD_DIR)
