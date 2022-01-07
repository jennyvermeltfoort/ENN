CC := gcc
AR := ar

CC_FLAGS := -MMD -MP -Wall

SRC_DIR := src
BUILD_DIR := build
OBJ_DIR := $(BUILD_DIR)/obj
TMP_DIR := $(BUILD_DIR)/tmp
BIN_DIR := $(BUILD_DIR)/bin
LIB_DIR := $(BUILD_DIR)/lib
LIB_API_DIR := $(LIB_DIR)/api

# Object created to be linked with the application. Currently the source is compiled into a static
# library, depending on future use cases this might change to a dynamic library.
LIB := $(LIB_DIR)/libenn.a

# Find all unit makefiles. See next comment for more information.
MAKEFILE := $(shell find $(SRC_DIR) -name Makefile)

# It is expected that each unit holds the required object files in its Makefile. Here the objects 
# and API directories are gathered and dumped into single variables. The headers in the API folder 
# are exposed to other units and the application.
$(foreach makefile,$(MAKEFILE), \
	$(eval include $(makefile)) \
	$(eval _UNIT_OBJ += $(foreach obj,$(UNIT_OBJ), \
		$(patsubst $(SRC_DIR)%, $(OBJ_DIR)%, $(dir $(makefile))$(obj)))) \
	$(eval _UNIT_API += $(foreach api,$(UNIT_API),$(dir $(makefile))$(api))) \
	$(eval _OBJ_DIRS += $(dir $(makefile))) \
	$(eval UNIT_OBJ := ) \
	$(eval UNIT_API := ))

CC_OBJECTS := $(_UNIT_OBJ)
CC_INCLUDES := $(patsubst %, -I%, $(_UNIT_API))

# Find all API header files and create build rules to expose them to the application.
SRC_API_HEADERS := $(shell find $(_UNIT_API) -name *.h)
LIB_API_HEADERS := $(patsubst $(SRC_DIR)/%.h, $(OBJ_DIR)/%.h, $(SRC_API_HEADERS))

.PHONY: all clean

$(LIB_API_DIR):
	@mkdir -p $@

$(LIB_DIR):
	@mkdir -p $@

# Flatten the folder structure for clean exposure.
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
