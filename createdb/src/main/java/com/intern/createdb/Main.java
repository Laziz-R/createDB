package com.intern.createdb;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.apache.ibatis.jdbc.ScriptRunner;

public class Main 
{
    final static String URL = "jdbc:postgresql://localhost:5432/";
    final static String USER = "postgres";
    final static String PASS = "6688";
    static String path = System.getProperty("user.dir")+"/src/main/java/recources/";

    public static void main( String[] args ) throws SQLException, FileNotFoundException
    {
        Connection con = DriverManager.getConnection(URL, USER, PASS);
        ScriptRunner sr = new ScriptRunner(con);
        Reader reader = new BufferedReader(new FileReader(path+"createDB.sql"));
        sr.runScript(reader);
    }
}
