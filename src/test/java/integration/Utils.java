package integration;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Utils {
    public static  int thread =0;
    public static int currentRut = 0;

    public static ArrayList extractValuesXml(String xml, String value){
        List<String> fcctrnrefs = new ArrayList<>();
        Pattern pattern = Pattern.compile("<"+value+">(.*?)</"+value+">");
        Matcher matcher = pattern.matcher(xml);

        while (matcher.find()) {
            fcctrnrefs.add(matcher.group(1));
        }
        for (String ref : fcctrnrefs) {
            System.out.println(ref);
        }
        return (ArrayList) fcctrnrefs;
    }

    public static String generarExternalReference() {
        Long num = Long.parseLong(DateTimeFormatter.ofPattern("MMddHHmmssSSS").format(LocalDateTime.now()));
        thread=thread>=99?0:thread+1;
        String valueThread = String.valueOf(thread);
        Random aleatorio = new Random();
        int intAletorio = aleatorio.nextInt(100);
        return "E"+num+intAletorio;
    }

    public static void guardarDatos(String str) {
        BufferedWriter bw = null;
        FileWriter fw = null;
        try {
            String ruta = "results/infoReporteLog.txt";
            File file = new File(ruta);
            if (!file.exists()) {
                file.createNewFile();
            }
            fw = new FileWriter(file.getAbsoluteFile(), true);
            bw = new BufferedWriter(fw);
            bw.write(str + "\n");
            bw.close();
            fw.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void guardarDatosNext(String str) {
        BufferedWriter bw = null;
        FileWriter fw = null;
        try {
            String ruta = "results/infoReportecred.txt";
            File file = new File(ruta);
            if (!file.exists()) {
                file.createNewFile();
            }
            fw = new FileWriter(file.getAbsoluteFile(), true);
            bw = new BufferedWriter(fw);
            bw.write(str + "\n");
            bw.close();
            fw.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
   public static String getCurrentDateFormat(){
        String value =DateTimeFormatter.ofPattern("YYYYMMdd").format(LocalDateTime.now());
        return value;
   }

    public static String autoCompleteValue() {
        return DateTimeFormatter.ofPattern("mmssSS").format(LocalDateTime.now());
    }

    public static String generateTrnxId() {
        Date dateTime = new Date();
        Random random = new Random();
        int randomNumber = random.nextInt(90) + 10;
        return new SimpleDateFormat("yyyyMMddHHmmss").format(dateTime) + randomNumber;
    }

    public static String getCurrentDateFormatFuture(){
        String value =DateTimeFormatter.ofPattern("YYYYMMdd").format(LocalDateTime.now().plusMonths(1));
        return value;
    }

    public static String getCurrentDateFormatPast(){
        String value =DateTimeFormatter.ofPattern("YYYYMMdd").format(LocalDateTime.now().minusDays(91));
        return value;
    }

    public static String getRutFromCustomerNumber(String customerNumber) {
        customerNumber = customerNumber.length() > 8 ? customerNumber.substring(1) : customerNumber;
        char[] num = (customerNumber).toCharArray();
        int cont = 1;
        int suma = 0;
        for (int i = 0; i <= num.length - 1; i++) {
            cont = cont == 7 ? 2 : cont + 1;
            suma = suma + Integer.parseInt(String.valueOf(num[num.length - 1 - i])) * cont;
        }
        int value = 11 - Math.abs((suma - ((suma / 11) * 11)));
        String digito = value == 11 ? "0" : value == 10 ? "K" : String.valueOf(value);
        return customerNumber + "-" + digito;
    }

    public static String getRut() {
        int rut = Integer.parseInt(("10").concat(DateTimeFormatter.ofPattern("mmssSS").format(LocalDateTime.now())));
        currentRut = currentRut == 0 ? rut + thread : currentRut;
        thread = thread > 99 ? 0 : thread + 1;
        rut = currentRut == rut ? rut + thread : rut;
        currentRut = rut;
        return getRutFromCustomerNumber(String.valueOf(currentRut));
    }


    public static int getCont() {
        thread = thread > 1000 ? 0 : thread + 1;
        return thread;
    }
}
