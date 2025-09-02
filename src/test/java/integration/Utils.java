package integration;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Utils {
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
}
