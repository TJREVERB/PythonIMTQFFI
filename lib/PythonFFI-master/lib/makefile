CC = gcc

default: libants.a

libants.a: ants.o
	ar rcs $@ $^
    
ants.o: ants.c ants-api.h
	$(CC) -c $<

clean:
	rm *.o *.a
