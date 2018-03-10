CC ?= cc

CFLAGS := $(CFLAGS) -I.

ifneq ("$(wildcard $(/usr/lib/libwlc.a))","")
LDFLAGS := $(LDFLAGS) -Bstatic -lwlc
else
LDFLAGS := $(LDFLAGS) -lwlc
endif

ifneq ("$(wildcard $(/usr/lib/libwlc.a))","")
LDFLAGS := $(LDFLAGS) -Bstatic -llua
else
LDFLAGS := $(LDFLAGS) -llua
endif


.PHONY: all clean
all: asc

clean:
	-rm *.o

asc: asc.o lua_api.o lua/lowlevel.o lua/root.o lua/consts.o
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

lua_api.o: lua_api.c lua_api.h lua/lowlevel.h lua/root.h lua/consts.h
	$(CC) -o $@ -c $< $(CFLAGS) $(LDFLAGS)

%.o: %.c %.h
	$(CC) -o $@ -c $< $(CFLAGS) $(LDFLAGS)

