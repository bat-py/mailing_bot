from pymysql.cursors import DictCursor
from pyrogram import Client
import pymysql


def mysql_handler():
    connection = pymysql.connect(
        host='archlinux.uz',
        user='crow',
        password='ifuckyou',
        db='tilla_ads',
        charset='utf8mb4',
        # cursorclass=DictCursor
    )



    cursor = connection.cursor()

    # Groups list (gets tuple like (('crow_test',), ('second_group',), ...)
    cursor.execute("SELECT * FROM `groups`;")

    groups_dict = cursor.fetchall()



def message_sender(messages, groups_list):
    app = Client('my_account')

    with app:
        for group in groups_list:
            for message in messages:
                app.send_message(group[0], message[0])


if __name__ == '__main__':
    data = mysql_handler()
    messages_list = data[0]
    groups_list = data[1]

    message_sender(messages_list, groups_list)
