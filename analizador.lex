%{
    int n_asig = 0;
    int n_lec = 0;
    int n_esc = 0;
    int correcto = 0;
%}
minus       [a-z]
mayus       [A-Z]^[M][R][W]
variable    ({minus})
constante   ({mayus})
digito      [0-9]
literal     ({digito}*)
ignore      (\t|\n)
operador    (\-|\+|\*|\/|\%)
operando    ({literal}|{variable}|{constante})
operacion   ({operando}({operador}{operando})+)
asignacion  ({variable}"="({operando}|({operacion}+)))
lectura     ("R"\({variable}\))
escritura   ("W"\(({operando}|{operacion})\))
sentencia   (({asignacion}|{lectura}|{escritura})";")
main        ("M{"({sentencia})*"}")
%%
{minus}             {printf("Minuscula %s\n", yytext);}
{mayus}             {printf("Mayuscula %s\n", yytext);}
{variable}          {printf("Variable %s\n", yytext);}
{constante}         {printf("Constante %s\n", yytext);}
{digito}            {printf("Digito %s\n", yytext);}           
{literal}           {printf("Literal %s\n", yytext);}
{operador}          {printf("Operador %s\n", yytext);}
{operando}          {printf("Operando %s\n", yytext);}
{operacion}         {printf("Operacion %s\n", yytext);}
{asignacion}        {printf("Asignacion %s\n", yytext);}
{lectura}           {printf("Lectura %s\n", yytext);}
{escritura}         {printf("Escritura %s\n", yytext);}
{sentencia}         {printf("Sentencia %s\n", yytext);}
{main}              {printf("Main %s\n", yytext);}
%%

int main()
{
    yylex();
    return 0;
}