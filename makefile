compile: md2tex

lex.yy.c: md2tex.l
	lex md2tex.l

md2tex: lex.yy.c md2tex_main.c
	cc md2tex_main.c -o md2tex -ll

clean:
	rm lex.yy.c md2tex
