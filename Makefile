t2c: t2c.o t2c_tree.o t_parse.o t_lex.o
	gcc -o t2c t2c.o t2c_tree.o t_parse.o t_lex.o

debug:
	bison -d --report=all -o t_parse.c t_parse.y

t_parse.h:	t_parse.y
	bison -d -o t_parse.c t_parse.y

t_parse.c:	t_parse.y
	bison -d -o t_parse.c t_parse.y

t_parse.o:	t_parse.c t2c.h t_parse.h t2c_tree.h
	gcc -c -o t_parse.o t_parse.c

t_lex.c:	t_lex.l
	flex -ot_lex.c t_lex.l

t_lex.o:	t_lex.c t2c.h t_parse.h t2c_tree.h
	gcc -c -o t_lex.o t_lex.c

t2c_tree.o: t2c_tree.c t2c_tree.h t2c.h
	gcc -c -o t2c_tree.o t2c_tree.c

t2c.o:	t2c.c t2c.h t_parse.h t2c_tree.h
	gcc -c -o t2c.o t2c.c

clean:
	del parse t2c.o t2c_tree.o t_parse.o t_parse.c t_parse.h t_lex.c t_lex.o

