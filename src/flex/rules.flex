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
    [^] dá matche em TODOS os caracteres
    [.] dá matche em todos os caracteres menos fim de linhas UNICODE

    Unicode letters = [:letter:]
    Unidode digits = [:digit:]

*/

%%

%class Lexer
%standalone

%unicode

%line
%column

line_terminator = \r|\n|\r\n|\u000A
white_space = {line_terminator} | [ \t\f]
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

%%

<YYINITIAL> {
    "/*"[^*/]*"*/"                                              { System.out.println("Found traditional comment: " + yytext()); }
    "//"[^]*{line_terminator}                                   { System.out.println("Found inline comment:" + yytext().substring(2));}
    {decimal_literal}                                           { System.out.println("Found decimal literal:" + yytext());}
    {float_literal}                                             { System.out.println("Found float literal:" + yytext());}
    {hex_literal}                                               { System.out.println("Found hex literal:" + yytext());}
    {white_space}                                               { /* Ignore */}
    .*|{line_terminator}                                        { /* process default here */ System.out.println("Found unmatched lexxema:" + yytext());}
}