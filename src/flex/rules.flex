package flex;

/*

    OBSERVAÇÕES:

    Especificação do GO: https://golang.org/ref/spec#unicode_letter
    Exemplo para a linguagem JAVA: https://github.com/moy/JFlex/blob/master/jflex/examples/java/java.flex
    Documentação JFLEX: http://jflex.de/manual.html#ExampleLexRules
    Tutorialzinho legal: https://www.skenz.it/compilers/classroom/practice1_6.pdf
    Projeto de uma galera das antigas com JFLEX/Cup para C: https://github.com/brunomb/CCompiler

    Caracter "_" é considerado uma letra em GO.
    a-f dá matche em todos os caracteres de a até f
    [xX] dá matche em x ou X

    Unicode letters = [:letter:]
    Unidode digits = [:digit:]

*/

%%

%class Lexer
%standalone

%unicode

%line
%column

new_line = \u000A | \n
comment = ("/*"[^*]"*/") | ("//"[^*]new_line)
letter = [:letter:] | _
identifier = letter([:digit:] | letter)*
decimal_digit = [0-9]
octal_digit   = [0-7]
hex_digit     = [0-9a-fA-F]
decimal_literal = [1-9]{decimal_digit}*
octal_literal = 0{octal_digit}*
hex_literal = 0[xX]{hex_digit}*
decimals = {decimal_digit}{decimal_digit}*
exponent = [eE][+-]?{decimals}
float_literal = ({decimals}"."{decimals}?{exponent}?) | ({decimals}{exponent}) | ("."{decimals}{exponent}?)

%x COMMENTS

%%

<YYINITIAL> {
    "/*"                                                        { yybegin(COMMENTS); }
    "//".*                                                      { /* consume //-comment */ }
    {decimal_literal} | {hex_literal} | {float_literal}         {System.out.println("Found literal:" + yytext());}
}

<COMMENTS> {
    [^*\n]+                                                     { }
    "*"+[^*/\n]*                                                { }
    \n                                                          {yyline++;}
    "*"+"/"                                                     {yybegin(0);}
}

<<EOF>>                                                         {}
