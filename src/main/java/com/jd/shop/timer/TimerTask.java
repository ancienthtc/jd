package com.jd.shop.timer;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * Created by ThinkPad on 2017/8/23.
 */
@Component
public class TimerTask {

    /**
     * 每天上午10点，下午2点，4点
     */
    @Scheduled(cron = "2 2 11,14,16 * * ?")
    public void test1()
    {
        System.out.println("job1 开始执行...");
    }

    @Scheduled(cron = "0/5 * * * * ?")//每隔5秒隔行一次
    public void test2()
    {
        System.out.println("job2 开始执行");
    }

}
