CC = gcc
CFLAGS = -Wall
LDFLAGS =
OBJFILES = y.tab.o lex.yy.o graphplan.o utilities.o hash.o planner.o dummy.o
TARGET = graphplan

all: $(TARGET)

$(TARGET): $(OBJFILES)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJFILES) $(LDFLAGS)
	mv graphplan ./bin/Debug/graphplan
	rm -f $(OBJFILES)
	
clean:
	rm -f  $(OBJFILES) $(TARGET) *~

