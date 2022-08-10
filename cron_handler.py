from crontab import CronTab
import sql_handler
import configparser

config = configparser.ConfigParser()
config.read('config.ini')


def new_job_creator(ready_data):
    """
    Создаем новую работу в cron исходя из полученных данных(ready_data).
    """
    path = config['cron']['path']
    user = config['cron']['user']
    my_cron = CronTab(user=user)
    # В chosen_hours хранится: [['12', '34'], ...]
    chosen_hours = ready_data['chosen_hours']

    for time in chosen_hours:
        job = my_cron.new(
            command=f'cd {path} && {path}/venv/bin/python {path}/message_sender.py {ready_data["timetable_id"]}',
            comment=ready_data['timetable_id']
        )

        job.minute.on(int(time[1]))
        job.hour.on(int(time[0]))

    my_cron.write()


def job_deletor_by_comment(timetable_id):
    user = config['cron']['user']
    my_cron = CronTab(user=user)

    my_cron.remove_all(comment=timetable_id)

    my_cron.write()

