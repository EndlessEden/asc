CC ?= cc

CFLAGS := $(CFLAGS) -I.

ifneq ("$(wildcard $(/usr/lib/libwlc.a))","")
LDFLAGS := $(LDFLAGS) -lwlc
else
LDFLAGS := $(LDFLAGS) -Bstatic -lwlc
endif

ifneq ("$(wildcard $(/usr/lib/liblua.a))","")
LDFLAGS := $(LDFLAGS) -llua
else
LDFLAGS := $(LDFLAGS) -Bstatic -llua
endif


.PHONY: all clean
all: asc

clean:
	-rm *.o

asc: asc.o lua_api.o lua/lowlevel.o lua/root.o lua/consts.o
	$(CC) -static -o $@ $^ $(CFLAGS) $(LDFLAGS)
	
lua_api.o: lua_api.c lua_api.h lua/lowlevel.h lua/root.h lua/consts.h
	$(CC) -static -o $@ -c $< $(CFLAGS) $(LDFLAGS)

%.o: %.c %.h
	$(CC) -static -o $@ -c $< $(CFLAGS) $(LDFLAGS)

