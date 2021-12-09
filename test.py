from crontab import CronTab


def new_job():
    my_cron = CronTab(user='crow')
    job = my_cron.new(
        command='sh /home/crow/test.sh',
        comment='My first cron'
    )

    #job.minute.on(0)
    #a = ['1', '5', 17]
    #job.hour.on(*a)
    my_cron.remove_all()

    my_cron.write()

new_job()

