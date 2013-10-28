OBJECTS= qt.o main.o
CFLAGS=-g -O1


all: test

test: $(OBJECTS)
	g++ $(CFLAGS) -o testProg $^

clean:
	rm *.o 

.c.o: *.h
	g++ -c $(CFLAGS) -o $@ $<

.cpp.o: *.h
	g++ -c $(CFLAGS) -o $@ $<

.PHONY: all clean