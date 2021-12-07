import pymysql
from pymysql.cursors import DictCursor


def connection_creator():
    con = pymysql.connect(
        host='archlinux.uz',
        user='crow',
        password='ifuckyou',
        db='telegram_manager',
        charset='utf8mb4',
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
        Вернет [ [ [button_name, 'button_id1216546'] ], [], [] ]
    """

    connection = connection_creator()
    cursor = connection.cursor()

    cursor.execute("SELECT timetable_id, timetable_name FROM time_table")
    timetable_dict = cursor.fetchall()

    connection.close()

    timetable_list = []

    for i in timetable_dict:
        button = [[i['timetable_name'], 'timetable_id'+i['timetable_id']]]
        timetable_list.append(button)

    return timetable_list