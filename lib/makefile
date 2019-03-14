CC = gcc

default: libimtq.a

libimtq.a: imtq.o
   ar rcs $@ $^
    
imtq.o: imtq-config.c imtq-config.h imtq-data.c imtq-data.h imtq-ops.c imtq-ops.h imtq-core.c imtq.h
    $(CC) -c $<

clean:
    rm *.o *.a
