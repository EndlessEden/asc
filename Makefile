CC ?= cc

CFLAGS := $(CFLAGS) -I.
LDFLAGS := $(LDFLAGS) -Bstatic -lwlc -Bstatic -llua

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

