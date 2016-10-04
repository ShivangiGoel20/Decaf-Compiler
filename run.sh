bison -d code.y
flex code.l
g++ code.tab.c lex.yy.c -lfl -o compiler
./compiler
