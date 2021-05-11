package com.intern.createdb;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Scanner;

import org.apache.ibatis.jdbc.ScriptRunner;

public class Main {
    static String path = System.getProperty("user.dir") + "/createdb/src/main/java/resources/";

    public static void main(String[] args) throws SQLException, InterruptedException, IOException {
        Properties props = new Properties();
        props.load(new FileInputStream(path+"config.properties"));

        final String URL = props.getProperty("URL");
        final String USER = props.getProperty("USER");
        final String PASS = props.getProperty("PASS");

        Scanner sc = new Scanner(System.in);
        Connection con = DriverManager.getConnection(URL, USER, PASS);
        ScriptRunner sr = new ScriptRunner(con);
        Reader reader;

        System.out.print("DROP and CREATE? (Y/N): ");
        if (sc.next().equalsIgnoreCase("Y")) {
            sr.setAutoCommit(true);
            sr.setStopOnError(true);

            // CREATE db
            reader = new BufferedReader(new FileReader(path + "/create_db.sql"));
            try {
                sr.runScript(reader);
            } catch (Exception e) {
                System.err.println(e.toString());
            }

            con = DriverManager.getConnection(URL + "library", USER, PASS);
            sr = new ScriptRunner(con);

            // CREATE tables
            for (File file : new File(path + "tables/").listFiles()) {
                if (file.getName().equals("ending.sql"))
                    continue;
                reader = new BufferedReader(new FileReader(file));
                try {
                    sr.runScript(reader);
                } catch (Exception e) {
                    System.err.println(e.toString());
                }
            }
            reader = new BufferedReader(new FileReader(path + "tables/ending.sql"));
            try {
                sr.runScript(reader);
            } catch (Exception e) {
                System.err.println(e.toString());
            }

            sr.setDelimiter(";;");
            // CREATE functions
            for (File file : new File(path + "functions/").listFiles()) {
                reader = new BufferedReader(new FileReader(file));
                try {
                    sr.runScript(reader);
                } catch (Exception e) {
                    System.err.println(e.toString());
                }
            }

            // INSERT data
            reader = new BufferedReader(new FileReader(path+"insert_data.sql"));
            try {
                sr.runScript(reader);
            } catch (Exception e) {
                System.err.println(e.toString());
            }            
        }

        System.out.print("Run other? (Y/N): ");
        if(sc.next().equalsIgnoreCase("Y")){
            con = DriverManager.getConnection(URL + "library", USER, PASS);
            sr = new ScriptRunner(con);
            for (File file : new File(path + "others/").listFiles()) {
                reader = new BufferedReader(new FileReader(file));
                try {
                    sr.runScript(reader);
                } catch (Exception e) {
                    System.err.println(e.toString());
                    return;
                }
            }
        }

    }
}
