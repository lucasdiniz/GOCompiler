package flex;
import java_cup.runtime.*;
import java_cup.sym;
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
%cup
%cupdebug
%debug

%unicode

%line
%column

%{

       private Symbol symbol(int type) {
           return new Symbol(type, yyline, yycolumn);
          }

        private Symbol symbol(int type, Object val) {
           return new Symbol(type, yyline, yycolumn, val);
          }

%}

identifier =  [:jletter:] [:jletterdigit:]*
line_terminator = \r|\n|\r\n|\u000A
white_space = {line_terminator} | [ \t\f]
comment = ("/*"[^*]"*/") | ("//"[^*]new_line)
letter = [:letter:] | _
decimal_digit = [0-9]
octal_digit   = [0-7]
hex_digit     = [0-9a-fA-F]
decimal_literal = [1-9]{decimal_digit}*
octal_literal = 0{octal_digit}*
hex_literal = 0[xX]{hex_digit}*
decimals = {decimal_digit}{decimal_digit}*
exponent = [eE][+-]?{decimals}
float_literal = ({decimals}"."{decimals}?{exponent}?) | ({decimals}{exponent}) | ("."{decimals}{exponent}?)
string_literal = "`"([^\\\`]|\\.)*"`" | \"([^\\\"]|\\.)*\"
imaginary_literal = ({float_literal}|{decimal_literal})i

%%

<YYINITIAL> {

    /*KEYWORDS*/

    "break"                                                     { return symbol(sym.BREAK, new String(yytext())); }
    "default"                                                   { return symbol(sym.DEFAULT, new String(yytext())); }
    "func"                                                      { return symbol(sym.FUNC, new String(yytext())); }
    "interface"                                                 { return symbol(sym.INTERFACE, new String(yytext())); }
    "select"                                                    { return symbol(sym.SELECT, new String(yytext())); }
    "case"                                                      { return symbol(sym.CASE, new String(yytext())); }
    "defer"                                                     { return symbol(sym.DEFER, new String(yytext())); }
    "go"                                                        { return symbol(sym.GO, new String(yytext())); }
    "map"                                                       { return symbol(sym.MAP, new String(yytext())); }
    "struct"                                                    { return symbol(sym.INTERFACE, new String(yytext())); }
    "chan"                                                      { System.out.println("Found keyword: " + yytext()); }
    "else"                                                      { System.out.println("Found keyword: " + yytext()); }
    "goto"                                                      { System.out.println("Found keyword: " + yytext()); }
    "package"                                                   { System.out.println("Found keyword: " + yytext()); }
    "switch"                                                    { System.out.println("Found keyword: " + yytext()); }
    "const"                                                     { System.out.println("Found keyword: " + yytext()); }
    "fallthrough"                                               { System.out.println("Found keyword: " + yytext()); }
    "if"                                                        { System.out.println("Found keyword: " + yytext()); }
    "range"                                                     { System.out.println("Found keyword: " + yytext()); }
    "type"                                                      { System.out.println("Found keyword: " + yytext()); }
    "continue"                                                  { System.out.println("Found keyword: " + yytext()); }
    "for"                                                       { System.out.println("Found keyword: " + yytext()); }
    "import"                                                    { System.out.println("Found keyword: " + yytext()); }
    "return"                                                    { System.out.println("Found keyword: " + yytext()); }
    "var"                                                       { System.out.println("Found keyword: " + yytext()); }
    
    /*OPERATORS AND PUNCTUATION*/


    "+"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "&"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "+= "                                                       { System.out.println("Found operator/punctuation: " + yytext()); }
    "&="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "&&"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "=="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "!="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "("                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    ")"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "-"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "|"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "-="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "|="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "||"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "<"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "<="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "["                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "]"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "*"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "^"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "*="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "^="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "<-"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    ">"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    ">="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "{"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "}"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "/"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "<<"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "/="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "<<="                                                       { System.out.println("Found operator/punctuation: " + yytext()); }
    "++"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "="                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    ":="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    ","                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    ";"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "%"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    ">>"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "%="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    ">>="                                                       { System.out.println("Found operator/punctuation: " + yytext()); }
    "--"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "!"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "..."                                                       { System.out.println("Found operator/punctuation: " + yytext()); }
    "."                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    ":"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "&^ "                                                       { System.out.println("Found operator/punctuation: " + yytext()); }
    "&^="                                                       { System.out.println("Found operator/punctuation: " + yytext()); }

    /*TOKENS*/

    "/*"[^*/]*"*/"{line_terminator}?                            { /* Ignore */ }
    "//"[^\n]*{line_terminator}?                                { /* Ignore */ }
    {decimal_literal}                                           { return symbol(sym.DECIMAL_LITERAL, new String(yytext())); }
    {float_literal}                                             { return symbol(sym.FLOAT_LITERAL, new String(yytext())); }
    {hex_literal}                                               { return symbol(sym.HEX_LITERAL, new String(yytext())); }
    {white_space}                                               { /* Ignore */}
    {identifier}                                                { return symbol(sym.IDENTIFIER, new String(yytext())); }
    {string_literal}                                            { return symbol(sym.STRING_LITERAL, new String(yytext())); }
    {imaginary_literal}                                         { return symbol(sym.IMAGINARY_LITERAL, new String(yytext())); }
    {octal_literal}                                             { return symbol(sym.OCTAL_LITERAL, new String(yytext())); }
}
