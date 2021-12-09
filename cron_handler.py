from crontab import CronTab
import sql_handler


def new_job_creator(ready_data):
    """
    Создаем новую работу в cron исходя из полученных данных(ready_data).
    """

    my_cron = CronTab(user='crow')

    job = my_cron.new(
        command=f'sh /home/crow/mailing_bot/message_sender.sh {ready_data["timetable_id"]}',
        comment=ready_data['timetable_id']
    )

    job.minute.on(0)
    chosen_hours_list = ready_data['chosen_hours'].split(',')
    job.hours.on(*chosen_hours_list)

    my_cron.write()


def job_deletor_by_comment(timetable_id):
    my_cron = CronTab(user='crow')

    my_cron.remove_all(comment=timetable_id)

    my_cron.write()

def job_deletor():
    my_cron = CronTab(user='crow')
    my_cron.remove_all()
    my_cron.write()

job_deletor()