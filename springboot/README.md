# springboot

关于springboot的部署相关的内容 

## 启动

```shell
java -jar -XX:MetaspaceSize=128m 
     -XX:MaxMetaspaceSize=128m 
     -Xms1024m -Xmx1024m
     -Xmn256m 
     -Xss256k 
     -XX:SurvivorRatio=8 
     -XX:+UseConcMarkSweepGC springboot项目.jar
```

-Xms1g： 最小内存最小
-Xmx1g： 最大内存最大
建议设置-Xms与-Xmx相同,以避免每次垃圾回收完成后JVM重新分配内存.

-XX:+UseG1GC
指定使用G1（GC收集器）

-XX:MaxGCPauseMillis=200
最长的GC暂停时间，如果时间过长，会相应调整空间的大小（单位是毫秒）

-XX:+UnlockExperimentalJVMOptions
有些时候当设置一个特定的JVM参数时，JVM会在输出“Unrecognized VM option”后终止。如果发生了这种情况，你应该首先检查你是否输错了参数。然而，如果参数输入是正确的，并且JVM并不识别，或许需要设置-XX:+UnlockExperimentalVMOptions 来解锁参数

-XX:G1NewSizePercent=20
设置要用作年轻代大小最小值的堆百分比。默认值是 Java 堆的 5%

-XX:G1MaxNewSizePercent=30
设置要用作年轻代大小最大值的堆大小百分比。默认值是 Java 堆的 60%。

-XX:+DisableExplicitGC
关闭系统调用GC功能 System.gc() 默认会触发一次Full Gc

-XX:+PrintGC
打印GC

-XX:+PrintGCDetails
打印GC详细信息

-XX:+PrintGCTimeStamps
打印GC时间戳

-Xloggc:/data/www/$project_name/online/logs/gc_log_8000.log
GC日志路径
