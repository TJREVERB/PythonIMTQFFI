CC = gcc

default: libimtq.a

libimtq.a: imtq.o
	ar rcs $@ $^
    
imtq.o: imtq.h imtq-config.c imtq-config.h imtq-data.c imtq-data.h imtq-ops.c imtq-ops.h imtq-core.c json.h json.c
	echo $(CC) -c $^

clean:
	rm *.o *.a
