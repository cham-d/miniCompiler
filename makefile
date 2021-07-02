build: myanalyzer


myanalyzer: lex.yy.c
	gcc lex.yy.c myanalyzer.tab.c -o mycompiler cgen.c -lfl
	 ./mycompiler < correct1.ms >> myprog.c //to programma se c

lex.yy.c: mylexer.l
	bison -d -v -r all myanalyzer.y
	flex mylexer.l
	
compile:
	gcc -std=c99 -Wall -o myprog myprog.c
	 @echo "************  PROGRAM STARTED ************"
	 @./myprog
	 @echo "\n************  PROGRAM HALTED ************"
clean: 
	rm lex.yy.c mycompiler myanalyzer.tab.c myanalyzer.tab.h myanalyzer.output myprog.c myprog
