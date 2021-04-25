package com.wind.app.flutter;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;

/**
 * created by wind on 4/25/21:4:21 PM
 *
 * https://time.geekbang.org/column/article/70966
 */
public class RuntimeUtil {


    /**
     * 系统剩余内存。关于系统内存状态，可以直接读取文件 /proc/meminfo。
     * 当系统可用内存很小（低于 MemTotal 的 10%）时，OOM、大量 GC、系统频繁自杀拉起等问题都非常容易出现。
     * @return
     */
    public static String getSystemRemainMemory(){
        String meminfoFilePath="/proc/meminfo";
        return readFile(meminfoFilePath);
    }

    /**
     * 应用使用内存。包括 Java 内存、RSS（Resident Set Size）、PSS（Proportional Set Size），
     * 我们可以得出应用本身内存的占用大小和分布。PSS 和 RSS 通过 /proc/self/smap 计算，
     * 可以进一步得到例如 apk、dex、so 等更加详细的分类统计。
     * @return
     */
    public static String getAppMemory(){
        String smapFilePath="/proc/self/smap";
        return readFile(smapFilePath);
    }

    /**
     * 虚拟内存可以通过 /proc/self/status 得到，通过 /proc/self/maps 文件可以得到具体的分布情况。
     * 有时候我们一般不太重视虚拟内存，但是很多类似 OOM、tgkill 等问题都是虚拟内存不足导致的。
     *
     * @return
     */
    public static String getVirtualMemory(){
        String mapsFilePath="/proc/self/maps";
        return readFile(mapsFilePath);
    }

    /**
     * 虚拟内存 可以获取线程数
     * @return
     */
    public String getProcessStatus(){
        String statusFilePath="/proc/self/status";
        return readFile(statusFilePath);
    }

    private static String readFile(String filePath){
        try (BufferedReader bufferedReader=new BufferedReader(
                new InputStreamReader(new FileInputStream(filePath),"iso-8859-1"))){

            StringBuilder sBuilder=new StringBuilder();
            String line;
            while ((line=bufferedReader.readLine())!=null){
                sBuilder.append(line);
            }
            return sBuilder.toString();

        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }
}
