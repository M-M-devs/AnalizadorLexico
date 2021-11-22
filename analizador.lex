%{
    int n_asig = 0;
    int n_lec = 0;
    int n_esc = 0;
    int correcto = 0;
    int main_correcto = 0;
    int punto_coma = 0;
    int lectura_incorrecta = 0;
%}
minus           [a-z]
ignore          [ \t\n]
variable        ({minus}*)
digito          [0-9]
literal         ({digito}+)
operador        (\-|\+|\*|\/|\%)
operando        ({literal}|{variable})
operacion       ({ignore}*{operando}({ignore}*{operador}{ignore}*{operando})+)
asignacion      ({ignore}*{variable}{ignore}*"="{ignore}*({operando}|{operacion}+){ignore}*)
lectura         ({ignore}*"R"{ignore}*\({ignore}*{variable}{ignore}*\))
lectura_err     ({ignore}*"R"{ignore}*\({ignore}*{literal}{ignore}*\))
escritura       ({ignore}*"W"{ignore}*\({ignore}*({operando}|{operacion}){ignore}*\))
sentencia       (({asignacion}|{lectura}|{escritura})";"{ignore}*)
sentencia_err   (({asignacion}|{lectura}|{escritura})+(\})?{ignore}*)
main            ({ignore}*"M"{ignore}*"{"({ignore}*{sentencia})*"}")
main_err        ({main}{ignore}*.+)
%%
{operacion}         {printf("Operacion %s\n", yytext);}
{asignacion}        {printf("Asignacion %s\n", yytext);}
{lectura}           {printf("Lectura %s\n", yytext);}
{escritura}         {printf("Escritura %s\n", yytext);}
{sentencia}         {printf("Sentencia %s\n", yytext);}
{lectura_err}       {lectura_incorrecta = 1;}
{sentencia_err}     {punto_coma = 1;}
{main}              {main_correcto = 1;}
{main_err}          {main_correcto = 0;}
%%
int main()
{
    yylex();
    printf("\n");
    if(main_correcto == 1){
        printf("Programa correcto\n");
    }
    else if(main_correcto == 0){
        printf("Error de sintaxis\n"); 
        if(punto_coma == 1)
           printf("Falta ;\n");
        if (lectura_incorrecta == 1)
            printf ("No se puede escribir en un literal\n");
       
    }
    return 0;
}