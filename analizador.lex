%{
    int n_asig = 0;
    int n_lec = 0;
    int n_esc = 0;
    int correcto = 0;
    int programa_correcto = 0;
    int main_correcto = 0;
    int punto_coma = 0;
    int lectura_incorrecta = 0;
    int asignacion_err = 0;
    int num_sentencia = 0;
    int num_sentencia_err = 0;

%}
minus           [a-z]
ignore          [ \t]
linea           [\n]
variable        ({minus}*)
digito          [0-9]
literal         ({digito}+)
operador        (\-|\+|\*|\/|\%)
operando        ({literal}|{variable})
operacion       ({ignore}*{operando}({ignore}*{operador}{ignore}*{operando})+)
asignacion      ({ignore}*{variable}{ignore}*"="{ignore}*({operando}|{operacion}+){ignore}*)
asignacion_err  ({ignore}*{literal}{ignore}*"="{ignore}*({operando}|{operacion}+){ignore}*)
lectura         ({ignore}*"R"{ignore}*\({ignore}*{variable}{ignore}*\))
lectura_err     ({ignore}*"R"{ignore}*\({ignore}*{literal}{ignore}*\))
escritura       ({ignore}*"W"{ignore}*\({ignore}*({operando}|{operacion}){ignore}*\))
sentencia       (({asignacion}|{lectura}|{escritura})";"{ignore}*)
sentencia_err   (({asignacion}|{lectura}|{escritura})+{linea}?(\})?{ignore}*)
main            ({ignore}*"M"{ignore}*"{"{linea}?({ignore}*{sentencia}{linea}?)*"}")
main_err        ({main}{ignore}*{linea}?(({ignore}*({sentencia}|{sentencia_err}){linea}?)*)+.+)
%%
{operacion}         {printf("Operacion %s\n", yytext);}
{asignacion}        {printf("Asignacion %s\n", yytext);}
{lectura}           {printf("Lectura %s\n", yytext);}
{escritura}         {printf("Escritura %s\n", yytext);}
{sentencia}         {num_sentencia++; printf("Sentencia %s\n", yytext);}
{lectura_err}       {lectura_incorrecta = 1;}
{sentencia_err}     {num_sentencia++; num_sentencia_err = num_sentencia; punto_coma = 1;}
{asignacion_err}    {asignacion_err = 1;}
{main}              {programa_correcto = 1;}
{main_err}          {main_correcto = 1;}
%%
int main()
{
    yylex();
    printf("\n");
    if(programa_correcto == 1){
        printf("Programa correcto\n");
    }
    else if(programa_correcto == 0){
        printf("Error de sintaxis:\n"); 
        if(punto_coma == 1)
           printf("Falta un ; en la sentencia %d\n", num_sentencia_err);
        if (lectura_incorrecta == 1)
            printf ("No se puede escribir en un literal\n");
        if (asignacion_err == 1)
            printf ("No se puede asignar un valor a un literal\n");
        if (main_correcto == 1 && punto_coma == 0)
            printf ("Sentencias declaradas fuera del main\n");
        if(main_correcto == 0)
            printf ("Falta main\n");

    }
    return 0;
}