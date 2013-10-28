OBJECTS=glFunctions.o main.o
CFLAGS=-g -O1
LDFLAGS=-lobjc -framework GLUT -framework OpenGL

all: test

test: $(OBJECTS)
	g++ $(LDFLAGS) $(CFLAGS) -o testProg $^

clean:
	rm *.o 

.c.o: *.h
	g++ -c $(CFLAGS) -o $@ $<

.cpp.o: *.h
	g++ -c $(CFLAGS) -o $@ $<

.PHONY: all clean

