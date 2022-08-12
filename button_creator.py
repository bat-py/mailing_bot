from aiogram.types import InlineKeyboardButton, InlineKeyboardMarkup, ReplyKeyboardMarkup, KeyboardButton
import sql_handler

def inline_keyboard_creator(buttons_list, row_width=2):
    """
    Args:
        buttons_list: Получает такой массив: [ [ [button_name, callback_data]... ], [ []... ], [ []... ] ]
        row_width:

    Returns:

    """

    ready_buttons = InlineKeyboardMarkup(row_width=row_width)

    for i in buttons_list:
        ready_row = []
        for j in i:
            button = InlineKeyboardButton(j[0], callback_data=j[1])
            ready_row.append(button)

        ready_buttons.add(*ready_row)

    return ready_buttons


def reply_keyboard_creator(buttons_list):
    ready_buttons = ReplyKeyboardMarkup(resize_keyboard=True)

    for i in buttons_list:
        row = [KeyboardButton(j) for j in i]
        ready_buttons.add(*row)

    return ready_buttons


def hours_buttons_list():
    """
    Returns:
        [['0:00', '0'], ['23:00', '23']]

    """
    hours = []
    n = 0
    row = []

    for i in range(24):
        hour = [str(i)+':00', 'hour'+str(i)]
        row.append(hour)

        if not (n+1)%4:
            hours.append(row)
            row = []
        n += 1

    return hours


def hours_menu_inline_buttons_creator():
    """
    Создает inline кнопки для меню hours_menu
    Returns:

    """
    # Создаем кнопки inline кнопки 0-9 и очистить, добавить, назад, далее(переход в следующий меню)
    hours_menu_buttons_list = [
        [['1', 't_1'], ['2', 't_2'], ['3', 't_3']],
        [['4', 't_4'], ['5', 't_5'], ['6', 't_6']],
        [['7', 't_7'], ['8', 't_8'], ['9', 't_9']],
        [['⬅️', 't_backspace'], ['0', 't_0'], ['🆗', 't_time_chosen']],
        [['Дальше', 't_all_hours_chosen']]
    ]
    hours_menu_buttons = inline_keyboard_creator(hours_menu_buttons_list, row_width=3)

    return hours_menu_buttons

