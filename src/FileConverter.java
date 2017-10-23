import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Collections;

public class FileConverter {

    public static String PATH = System.getProperty("user.dir") + "/data";
    private static String lineSep = System.getProperty("line.separator");


    public static void readClientCSV() throws IOException {

        System.out.println("File read at: " + PATH);
        File clientCSV = new File(PATH,"client.csv");
        BufferedReader br_originalDataset = new BufferedReader(new InputStreamReader(new FileInputStream(clientCSV)));

        //generated file

        File client_parsed = new File("client_parsed.csv");
        BufferedWriter bw_clientParsed = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(client_parsed)));
        try {

            String ageColumn, genderColumn;
            String line = null;
            int i = 0;

            for(line = br_originalDataset.readLine(); line != null; line = br_originalDataset.readLine(), i++) {

                System.out.println("LINE: " + line);


                if(i > 0) {

                    String[] rowVal = line.split(";");
                    String date = rowVal[1];
                    String date_parsed = date.replace("\"", "");

                    int month = Integer.valueOf(date_parsed) % 10000 / 100;
                    int year = Integer.valueOf(date_parsed) / 10000 + 1900;
                    int day = Integer.valueOf(date_parsed) % 100;
                    int age = 2017 - year;
                    String gender = null;


                    if (month > 50) {
                        month = month - 50;
                        gender = "female";

                    } else
                        gender = "male";

                    bw_clientParsed.write(line + ";" + age + ";" + gender + "\n");

                } else {

                    ageColumn = String.valueOf("; Age");
                    genderColumn = String.valueOf("; Gender");
                    bw_clientParsed.write(line + ageColumn + genderColumn + ";" + "\n");

                }


            }

        } catch (Exception e) {
            System.out.println(e);
        }

    }

    public static String build_line(String[] rowValues) {

        String line = "";


        String date_parsed = rowValues[1].replace("\"", "");
        int clientID = Integer.valueOf(rowValues[0]);
        int districtID = Integer.valueOf(rowValues[2]);
        // System.out.println("PARSED: " + date_parsed);
        line += clientID + ";";
        line += date_parsed +";";
        line += districtID + ";";


        return line;
    }

    public static void writeToFile(BufferedReader bufferToRead, BufferedWriter bufferToWrite) throws IOException {

        String[] rowVal = null;

        for (String line = bufferToRead.readLine(); line != null; line = bufferToRead.readLine()) {
            bufferToWrite.write(line + lineSep);
        }
    }



    public static void main(String[] args) {
        try {
            readClientCSV();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void parseGenre() {

    }
}