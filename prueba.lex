car [a-zA-Z]
    int a = 0;  
%%
{car} {a++; printf("%d\n", a);}
%%
int yywrap(){
    return 1;
}

int main()
{
    return 1;
}