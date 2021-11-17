%{
    int i = 0;
%}

%%

([a-zA-Z0-9])*  {i++;}
.               {;}
"\n"            {printf("Num de palabras o cigras %d\n", i); i = 0;}
%%
int yywrap(){
    printf("estoy pasando por yywrap()");
    return 1;
}
int main()
{
    yylex();
    return 0;
}