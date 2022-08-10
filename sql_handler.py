import pymysql
from pymysql.cursors import DictCursor
import random
import configparser

config = configparser.ConfigParser()
config.read('config.ini')


def connection_creator():
    con = pymysql.connect(
        host=config['mysql']['host'],
        user=config['mysql']['user'],
        password=config['mysql']['password'],
        db=config['mysql']['db'],
        charset=config['mysql']['charset'],
        cursorclass=DictCursor
    )

    return con


def get_chats_id_list():
    connection = connection_creator()
    cursor = connection.cursor()

    cursor.execute("SELECT chat_id FROM `groups`;")
    chats_id_dict = cursor.fetchall()
    connection.close()

    chats_id_list = [int(group['chat_id']) for group in chats_id_dict]

    return chats_id_list


def add_new_chat(message):
    connection = connection_creator()
    cursor = connection.cursor()

    chat_id = message.chat.id
    title = message.chat.title
    username = message.chat.username

    cursor.execute("INSERT INTO `groups`(chat_id, username, title) VALUES(%s, %s, %s);",
                   (chat_id, username, title)
                   )
    connection.commit()
    connection.close()


def del_group(chat_id):
    connection = connection_creator()
    cursor = connection.cursor()

    cursor.execute("DELETE FROM `groups` WHERE chat_id = %s", (chat_id,))

    connection.commit()
    connection.close()


def get_password():
    connection = connection_creator()
    cursor = connection.cursor()

    cursor.execute("SELECT value FROM data WHERE name = 'password'")
    password = cursor.fetchone()

    connection.close()

    return password['value']


def get_admin_name():
    connection = connection_creator()
    cursor = connection.cursor()

    cursor.execute("SELECT value FROM data WHERE name = 'admin_name'")
    password = cursor.fetchone()

    connection.close()

    return password['value']


def get_timetable_list():
    """
    Returns:
        Вернет [ [ [button_name, 'timetable_id1216546'] ], [], [] ]
    """

    connection = connection_creator()
    cursor = connection.cursor()

    cursor.execute("SELECT timetable_id, timetable_name FROM time_table")
    timetable_dict = cursor.fetchall()

    connection.close()

    timetable_list = []

    for i in timetable_dict:
        button = [[i['timetable_name'], 'timetable_id' + str(i['timetable_id'])]]
        timetable_list.append(button)

    return timetable_list


def get_info_about_timetable(timetable_id):
    """
    Args:
        timetable_id:

    Returns:
        Вернет dict: {timetable_id, timetable_name, groups_id, hours, mailing_text, term, groups_name_username_list}
    """

    connection = connection_creator()
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM time_table WHERE timetable_id = %s", (timetable_id,))
    info_about_timetable = cursor.fetchone()

    groups_id = info_about_timetable['groups_id']
    groups_id_list = groups_id.split(',')

    if len(groups_id_list) == 1:
        cursor.execute("SELECT title, username FROM `groups` WHERE chat_id = %s", groups_id_list)
    else:
        cursor.execute("SELECT title, username FROM `groups` WHERE chat_id in %s", (groups_id_list,))

    groups_title_username_list = cursor.fetchall()
    groups_name = ''
    for i in groups_title_username_list:
        s = f'{i["title"]} (@{i["username"]}), '
        groups_name += s

    groups_name_username = groups_name[:-2]
    info_about_timetable['groups_name_username_list'] = groups_name_username

    connection.close()

    return info_about_timetable


def get_groups_list():
    """
    Returns:
        Вернет готовый список чтобы создать кнопки : [ [ [ title , 'group_id'+chat_id ] ], []... ]
    """

    connection = connection_creator()
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM `groups`;")
    groups_dict = cursor.fetchall()

    connection.close()

    # Преобразуем groups_dict на нужный формат чтобы создать кнопки
    groups_list = []

    for group in groups_dict:
        chat_id = 'group_id' + group['chat_id']
        title = group['title']

        row = [[title, chat_id]]
        groups_list.append(row)

    return groups_list


def timetable_id_generator():
    connection = connection_creator()
    cursor = connection.cursor()

    while True:
        gen_id = str(random.randint(100000, 999999))
        cursor.execute("SELECT timetable_id FROM time_table WHERE timetable_id = %s", (gen_id,))
        responce = cursor.fetchone()

        if not responce:
            connection.close()
            return gen_id


def ready_data_handler(ready_data):
    connection = connection_creator()
    cursor = connection.cursor()

    ready_data_list = list(map(lambda i: i[1], ready_data.items()))

    # В chosen_hours хранится: [['12', '34'], ...]. А мы создадим из них '12:34, 23:01, ...' и запишем в базу
    chosen_hours = ready_data_list[3]
    chosen_hours_str = ''

    for time in chosen_hours:
        chosen_hours_str += time[0] + ':' + time[1] + ', '

    ready_data_list[3] = chosen_hours_str.rstrip(', ')

    cursor.execute("INSERT INTO time_table VALUES(%s, %s, %s, %s, %s, %s, %s, %s);", ready_data_list)
    connection.commit()

    connection.close()


def get_timetable_list_for_delete():
    """
    Returns:
        Вернет [ [ [button_name, 'timetable_id1216546'] ], [], [] ]
    """

    connection = connection_creator()
    cursor = connection.cursor()

    cursor.execute("SELECT timetable_id, timetable_name FROM time_table")
    timetable_dict = cursor.fetchall()

    connection.close()

    timetable_list = []

    for i in timetable_dict:
        button = [[i['timetable_name'], 'chosen_timetable_id_for_delete' + str(i['timetable_id'])]]
        timetable_list.append(button)

    return timetable_list


def get_timetable_title(timetable_id_for_delete):
    connection = connection_creator()
    cursor = connection.cursor()

    cursor.execute("SELECT timetable_name FROM time_table WHERE timetable_id = %s", (timetable_id_for_delete,))
    timetable = cursor.fetchone()

    connection.close()

    return timetable['timetable_name']


def delete_timetable(timetable_id):
    connection = connection_creator()
    cursor = connection.cursor()

    cursor.execute("DELETE FROM time_table WHERE timetable_id = %s", (timetable_id,))
    connection.commit()

    connection.close()


def get_groups_id_mailing_text_image(timetable_id):
    """

    Args:
        timetable_id:

    Returns:
        groups_id_list, mailing_text, mailing_photo
    """
    connection = connection_creator()
    cursor = connection.cursor()

    cursor.execute("SELECT groups_id, mailing_text, image, video_id FROM time_table WHERE timetable_id = %s", (timetable_id,))
    data = cursor.fetchone()

    groups_id_list = data['groups_id'].split(',')
    mailing_text = data['mailing_text']
    mailing_image = data['image']
    mailing_video = data['video_id']

    connection.close()

    return groups_id_list, mailing_text, mailing_image, mailing_video


def change_password(new_password):
    connection = connection_creator()
    cursor = connection.cursor()

    cursor.execute("UPDATE data SET value = %s WHERE name = 'password'", (new_password,))
    connection.commit()

    connection.close()


def get_data_from_data_table(name):
    connection = connection_creator()
    cursor = connection.cursor()

    cursor.execute("SELECT value FROM data WHERE name = %s", (name,))
    support_text = cursor.fetchone()

    connection.close()

    if not support_text:
        support = ''
    else:
        support = support_text['value']

    return support
