# KCOMPILE can be set by whoever calls this file
# e.g., `make KCOMPILE=xxxxx`
KCOMPILE ?= ./k-framework/tools/kompile.pl

# this is the name of the main maude module
LANGUAGE_NAME = KRUBY

# this are all interesting modules (used to latexify)
LANGUAGE_MODULES = KRUBY-SYNTAX


LATEX_STYLE = bb

#this is the basename of the main file
MAIN_FILE = kruby

# this is a space-separated list of basename maude files to run
#TESTS = simple-untyped-test.m

TOOL_DIR = $(dir $(KCOMPILE))
include $(TOOL_DIR)make-helper.mk
