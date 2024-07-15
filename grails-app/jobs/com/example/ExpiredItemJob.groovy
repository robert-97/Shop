package com.example

import grails.gorm.transactions.Transactional
import org.quartz.JobExecutionContext

class ExpiredItemJob {

    static triggers = {
        cron name: 'myCronTrigger', cronExpression: '0 0 0 * * ?' // Runs every day 00:00
    }
    ShopService shopService
    @Transactional
    def execute(JobExecutionContext job) {
        shopService.checkAndReturnExpiredItems()
    }
}