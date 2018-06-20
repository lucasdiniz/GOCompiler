/**
 * Created by lucasdiniz on 15/05/2018.
 */

import cup.Parser;
import flex.Lexer;

import java.io.File;
import java.io.FileReader;


public class Main {

    public static void main(String args[]) {
        Lexer s;

        try{
            s = new Lexer(new FileReader(new File( System.getProperty("user.dir") + "/test/input/001.go")));
            Parser p = new Parser(s);

            Object result = p.parse().value;
        } catch(Exception e){
            System.out.println(e.getMessage());
        }

    }

}
