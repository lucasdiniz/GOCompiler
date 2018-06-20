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
    "chan"                                                      { return symbol(sym.CHAN, new String(yytext())); }
    "else"                                                      { return symbol(sym.ELSE, new String(yytext())); }
    "goto"                                                      { return symbol(sym.INTERFACE, new String(yytext())); }
    "package"                                                   { return symbol(sym.PACKAGE, new String(yytext())); }
    "switch"                                                    { return symbol(sym.SWITCH, new String(yytext())); }
    "const"                                                     { return symbol(sym.CONST, new String(yytext())); }
    "fallthrough"                                               { return symbol(sym.FALLTHROUGH, new String(yytext())); }
    "if"                                                        { return symbol(sym.IF, new String(yytext())); }
    "range"                                                     { return symbol(sym.RANGE, new String(yytext())); }
    "type"                                                      { return symbol(sym.TYPE, new String(yytext())); }
    "continue"                                                  { return symbol(sym.CONTINUE, new String(yytext())); }
    "for"                                                       { return symbol(sym.FOR, new String(yytext())); }
    "import"                                                    { return symbol(sym.IMPORT, new String(yytext()));}
    "return"                                                    { return symbol(sym.RETURN, new String(yytext())); }
    "var"                                                       { return symbol(sym.VAR, new String(yytext()));  }
    
    /*OPERATORS AND PUNCTUATION*/


    "+"                                                         { return symbol(sym.PLUS, new String(yytext()));  }
    "&"                                                         { return symbol(sym.BIT_AND, new String(yytext())); }
    "+= "                                                       { return symbol(sym.PLUS_ASSINGMENT, new String(yytext())); }
    "&="                                                        { return symbol(sym.BIT_AND_ASSINGMENT, new String(yytext())); }
    "&&"                                                        { return symbol(sym.LOGICAL_AND, new String(yytext())); }
    "=="                                                        { return symbol(sym.EQUALS, new String(yytext())); }
    "!="                                                        { return symbol(sym.NOT_EQUALS, new String(yytext())); }
    "("                                                         { return symbol(sym.OPEN_PARENTHESES, new String(yytext())); }
    ")"                                                         { return symbol(sym.CLOSE_PARENTHESES, new String(yytext())); }
    "-"                                                         { return symbol(sym.MINUS, new String(yytext())); }
    "|"                                                         { return symbol(sym.BIT_OR, new String(yytext())); }
    "-="                                                        { return symbol(sym.MINUS_ASSINGMENT, new String(yytext())); }
    "|="                                                        { return symbol(sym.BIT_OR_ASSINGMENT, new String(yytext())); }
    "||"                                                        { return symbol(sym.LOGICAL_OR, new String(yytext())); }
    "<"                                                         { return symbol(sym.LESS_THAN, new String(yytext())); }
    "<="                                                        { return symbol(sym.LESS_THAN_EQUALS, new String(yytext())); }
    "["                                                         { return symbol(sym.OPEN_SQUARE_BRACKET, new String(yytext())); }
    "]"                                                         { return symbol(sym.CLOSE_SQUARE_BRACKET, new String(yytext())); }
    "*"                                                         { return symbol(sym.MULTIPLICATION, new String(yytext())); }
    "^"                                                         { return symbol(sym.BIT_XOR, new String(yytext())); }
    "*="                                                        { return symbol(sym.MULTIPLICATION_ASSINGMENT, new String(yytext())); }
    "^="                                                        { return symbol(sym.BIT_XOR_ASSINGMENT, new String(yytext())); }
    "<-"                                                        { return symbol(sym.LEFT_ARROW, new String(yytext())); }
    ">"                                                         { return symbol(sym.GREATER_THAN, new String(yytext())); }
    ">="                                                        { return symbol(sym.GREATER_THAN_EQUALS, new String(yytext())); }
    "{"                                                         { return symbol(sym.OPEN_CURLY_BRACKETS, new String(yytext())); }
    "}"                                                         { return symbol(sym.CLOSE_CURLY_BRACKETS, new String(yytext())); }
    "/"                                                         { return symbol(sym.DIVISION, new String(yytext())); }
    "<<"                                                        { return symbol(sym.BIN_SHIFT_LEFT, new String(yytext())); }
    "/="                                                        { return symbol(sym.DIVISION_ASSINGMENT, new String(yytext())); }
    "<<="                                                       { return symbol(sym.BIN_SHIFT_LEFT_ASSINGMENT, new String(yytext())); }
    "++"                                                        { return symbol(sym.PLUS_PLUS, new String(yytext())); }
    "="                                                         { return symbol(sym.ASSINGMENT, new String(yytext())); }
    ":="                                                        { return symbol(sym.COLON_EQUALS, new String(yytext())); }
    ","                                                         { return symbol(sym.COMMA, new String(yytext())); }
    ";"                                                         { return symbol(sym.SEMICOLON, new String(yytext())); }
    "%"                                                         { return symbol(sym.PERCENT, new String(yytext())); }
    ">>"                                                        { return symbol(sym.BIN_SHIFT_RIGHT, new String(yytext())); }
    "%="                                                        { return symbol(sym.PERCENT_EQUALS, new String(yytext())); }
    ">>="                                                       { System.out.println("Found operator/punctuation: " + yytext()); }
    "--"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "!"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "..."                                                       { System.out.println("Found operator/punctuation: " + yytext()); }
    "."                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    ":"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "&^ "                                                       { System.out.println("Found operator/punctuation: " + yytext()); }
    "&^="                                                       { System.out.println("Found operator/punctuation: " + yytext()); }

    /*TOKENS*/

    "/*"[^*/]*"*/"{line_terminator}?                            { System.out.println("Found traditional comment: " + yytext()); yyline++; yybegin(0);}
    "//"[^\n]*{line_terminator}?                                { System.out.println("Found inline comment:" + yytext().substring(2));}
    {decimal_literal}                                           { System.out.println("Found decimal literal:" + yytext());}
    {float_literal}                                             { System.out.println("Found float literal:" + yytext());}
    {hex_literal}                                               { System.out.println("Found hex literal:" + yytext());}
    {white_space}                                               { /* Ignore */}
    {identifier}                                                { System.out.println("Found identifier: " + yytext()); }
    {string_literal}                                            { System.out.println("Found string literal: " + yytext()); }
    {imaginary_literal}                                         { System.out.println("Found imaginary literal: " + yytext()); }
    {octal_literal}                                             { System.out.println("Found octal literal: " + yytext()); }
}
