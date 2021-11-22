LDFLAGS:=-L/usr/local/opt/flex/lib
CPPFLAGS:=-I/usr/local/opt/flex/include

all:
	flex analizador.lex
	gcc $(LDFLAGS) $(CPPFLAGS) lex.yy.c -o prog -lfl
	./prog

prueba:
	flex prueba.lex
	gcc $(LDFLAGS) $(CPPFLAGS) lex.yy.c -lfl 
	./a.out prueba.txt

clean:
	rm -rf lex.yy.c a.out