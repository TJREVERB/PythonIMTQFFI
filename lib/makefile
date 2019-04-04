CC = gcc

default: libimtq.a

libimtq.a: imtq-config.o imtq-data.o imtq-ops.o imtq-core.o json.o i2c.o
	ar rcs $@ $^
    
imtq.o: imtq.h imtq-config.c imtq-config.h imtq-data.c imtq-data.h imtq-ops.c imtq-ops.h imtq-core.c json.h json.c i2c.h i2c.c
	echo $(CC) -c $^

clean:
	rm *.o *.a
