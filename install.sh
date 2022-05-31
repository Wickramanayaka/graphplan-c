gcc -Wall -g  -c dummy.c -o ./obj/Debug/dummy.o
gcc -Wall -g  -c graphplan.c -o ./obj/Debug/graphplan.o
gcc -Wall -g  -c hash.c -o ./obj/Debug/hash.o
gcc -Wall -g  -c lex.yy.c -o ./obj/Debug/lex.yy.o 
gcc -Wall -g  -c planner.c -o ./obj/Debug/planner.o
gcc -Wall -g  -c utilities.c -o ./obj/Debug/utilities.o
gcc -Wall -g  -c y.tab.c -o ./obj/Debug/y.tab.o

gcc  -o ./bin/Debug/graphplan ./obj/Debug/dummy.o ./obj/Debug/graphplan.o ./obj/Debug/hash.o ./obj/Debug/lex.yy.o ./obj/Debug/planner.o ./obj/Debug/utilities.o ./obj/Debug/y.tab.o   

