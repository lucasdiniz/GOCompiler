/**
 * Created by lucasdiniz on 15/05/2018.
 */

import flex.Lexer2;

import java.io.File;
import java.io.FileReader;


public class Main {

    public static void main(String args[]) {
        Lexer2 s;

        try{
            s = new Lexer2(new FileReader(new File( System.getProperty("user.dir") + "/test/input/001.go")));
            s.next_token();
        } catch(Exception e){
            System.out.println(e.getMessage());
        }

    }

}
