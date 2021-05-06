package com.intern.createdb;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.apache.ibatis.jdbc.ScriptRunner;

public class Main 
{
    final static String USER = "postgres";
    final static String PASS = "6688";
    static String URL = "jdbc:postgresql://localhost:5432/";
    static String path = System.getProperty("user.dir")+"/createdb/src/main/java/resources/";

    public static void main( String[] args ) throws SQLException, FileNotFoundException, InterruptedException
    {
        System.out.println(path);
        Connection con = DriverManager.getConnection(URL, USER, PASS);
        ScriptRunner sr = new ScriptRunner(con);
        sr.setAutoCommit(true);
        sr.setStopOnError(true);

        // // CREATE DB
        // Reader reader = new BufferedReader(new FileReader(path+"/createDB.sql"));
        // sr.runScript(reader);
        // con.close();

        // con = DriverManager.getConnection(URL+"library", USER, PASS);
        // sr = new ScriptRunner(con);

        // // CREATE TABLES
        // for(File file: new File(path+"tables/").listFiles()){
        //     if(file.getName().equals("ending.sql")) continue;
        //     reader = new BufferedReader(new FileReader(file));
        //     sr.runScript(reader);
        // }
        // reader = new BufferedReader(new FileReader(path+"tables/ending.sql"));
        // sr.runScript(reader);

        // CREATE FUNCTIONS
        // for(File file: new File(path+"functions/").listFiles()){
        //     reader = new BufferedReader(new FileReader(file));
        //     sr.runScript(reader);
        //     Thread.sleep(1000);
        // }
        Reader reader = new BufferedReader(new FileReader(path+"functions/test.sql"));
        sr.runScript(reader);


    }
}
