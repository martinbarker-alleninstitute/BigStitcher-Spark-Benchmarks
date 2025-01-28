package net.preibisch.bigstitcher.spark.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class LogUtil {
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");

    public static void println(String message) {
        String timestamp = dateFormat.format(new Date());
        System.out.println("[" + timestamp + "] " + message);
    }
}
