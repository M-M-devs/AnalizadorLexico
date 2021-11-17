%{
    #include <stdio.h>
    int n_asig = 0;
    int n_lec = 0;
    int n_esc = 0;
    int correcto = 1;
%}
minus       [a-z]
mayus       [A-Z][^W][^R][^M]
variable    ({minus}+)
constante   ({mayus}+)
digito      [0-9]
literal     ({digito}+)
operador    (\-|\+|\*|\/|\%)
operando    ({literal} | {variable} | {constante})
asignacion  ({variable} \= ({operacion} | {operando}))
lectura     ([R] \( {var} \))
escritura   ([W] \( {operando} | {operador} \))
sentencia   ( ({asignacion} | {lectura} | {escritura}) [;] )
main        ([M] \{ (sentencia)* \})
%%
asignacion        n_asig++;
lectura           n_lec++;
escritura         n_esc++;
main              correcto=0;
%%
int yywrap(){
    if (correcto)
        printf("Programa correcto");
    printf("Numero de lecturas %d, Numero de escrituras %d, Numero de asignacioones %d \n", n_lec, n_esc, n_asig);
    return 1;
}
int main()
{
    yylex();
    return 0;
}