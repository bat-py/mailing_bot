from aiogram import Dispatcher, types
from aiogram.dispatcher import FSMContext
from aiogram.dispatcher.filters.state import State, StatesGroup
from aiogram.types import ReplyKeyboardRemove
import sql_handler
import button_creator
import datetime
import cron_handler


class MyStates(StatesGroup):
    waiting_for_password = State()
    waiting_for_new_timetable_name = State()
    waiting_for_groups = State()
    waiting_for_hours = State()
    waiting_for_mailing_message_photo_caption = State()
    waiting_for_term = State()
    processing_data = State()
    waiting_for_new_password = State()
    settings_menu = State()


async def admin_panel(message: types.Message, state: FSMContext):
    await state.finish()

    if message.chat.type == 'private':
        msg = 'Введите пароль:'

        await MyStates.waiting_for_password.set()
        await message.answer(msg)


async def admin_panel_menu(message_or_callback_query, state: FSMContext):
    await state.finish()

    admin_name = sql_handler.get_admin_name()
    mesg = f'Добро пожаловать {admin_name} :)'
    inline_buttons_list = [
        [['Список расписаний', 'timetable_list']],
        [['Добавить новое расписание', 'add_new_timetable']],
        [['Удалить расписание', 'delete_timetable']],
        [['Настройки', 'settings']]
    ]
    ready_buttons = button_creator.inline_keyboard_creator(inline_buttons_list)

    await message_or_callback_query.bot.send_message(
        message_or_callback_query.from_user.id,
        mesg,
        reply_markup=ready_buttons
    )


async def password_checker(message: types.Message, state: FSMContext):
    password = sql_handler.get_password()

    if message.text != password:
        await message.answer('❌ Неверный пароль! Попробуйте еще раз')
        return

    await state.finish()

    await admin_panel_menu(message, state)


# # # 1-menu)Timetable list menu
async def timetable_list_handler(callback_query: types.CallbackQuery, state: FSMContext):
    # Вернет [ [ [button_name, 'timetable_id1216546'] ], [], [] ]
    timetable_list = sql_handler.get_timetable_list()
    #print(timetable_list)
    mesg = 'Список расписаний:'
    inline_buttons = button_creator.inline_keyboard_creator(timetable_list)

    # Удаляем inline кнопки главного меню
    await callback_query.bot.edit_message_reply_markup(
        callback_query.message.chat.id,
        callback_query.message.message_id
    )

    await callback_query.bot.send_message(
        callback_query.from_user.id,
        mesg,
        reply_markup=inline_buttons
    )


async def show_info_about_timetable(callback_query: types.CallbackQuery, state: FSMContext):
    """
    Returns:
        Покажет информацию о выбранном расписании
    """
    timetable_id = callback_query.data.replace('timetable_id', '')
    timetable_info = sql_handler.get_info_about_timetable(timetable_id)

    hours = timetable_info['hours'].replace(',', ', ')

    full_mailing_text = timetable_info['mailing_text']
    mailing_text = full_mailing_text[:16] + '...'

    mesg = f"""
Расписание <b>{timetable_info["timetable_name"]}</b>

Список групп:
{timetable_info["groups_name_username_list"]}

Время:
{hours}

Сообщение рассылкы:
{mailing_text}

Срок:
{timetable_info['term']}
"""
    button = button_creator.reply_keyboard_creator([['Назад', 'Главное меню']])

    # Удаляем inline кнопки меню "Список расписаний:"
    await callback_query.bot.edit_message_reply_markup(
        callback_query.message.chat.id,
        callback_query.message.message_id
    )

    await callback_query.bot.send_message(
        callback_query.from_user.id,
        mesg,
        reply_markup=button,
        parse_mode='html'
    )


# # # Get timetable name menu:
async def add_new_timetable_menu(callback_query: types.CallbackQuery, state: FSMContext):
    mesg = 'Введите имя расписания:'
    button = button_creator.reply_keyboard_creator([['Назад', 'Главное меню']])

    # Удаляем inline кнпоки главного меню
    message_id = callback_query.message.message_id
    await callback_query.bot.edit_message_reply_markup(
        callback_query.from_user.id,
        message_id
    )

    await MyStates.waiting_for_new_timetable_name.set()

    await callback_query.bot.send_message(
        callback_query.from_user.id,
        mesg,
        reply_markup=button
    )


async def timetable_name_chosen(message: types.Message, state: FSMContext):
    """
    Args:
        message: message.text хранит имя расписание.
        state:

    Returns:
        Функция сохраняет имя расписание и отравит сообщение "Выберите группы:"

    """
    # Changing status to waiting_for_groups
    await MyStates.waiting_for_groups.set()

    # Saving chosen timetable name
    timetable_name = message.text
    await state.update_data(timetable_name=timetable_name)

    # Sending message "Choose groups" with inline buttons of groups
    mesg = "Выберите группы:"
    # Получает список всех групп куда добавлен бот: [ [ [ title , 'group_id'+chat_id ] ], []... ]
    buttons_list = sql_handler.get_groups_list()
    buttons_list.append([['Дальше', 'all_groups_chosen']])
    ready_buttons = button_creator.inline_keyboard_creator(buttons_list)

    # Creating blank list "chosen_groups" in state for saving chosen groups
    await state.update_data(chosen_groups=[])

    await message.answer(
        mesg,
        reply_markup=ready_buttons
    )


async def timetable_name_menu_back_button(message: types.Message, state: FSMContext):
    await admin_panel_menu(message, state)


# # # 2-menu) Choise groups menu system:
async def groups_list_menu(callback_query: types.CallbackQuery, state: FSMContext):
    """
    Функция запускают 2 функции: one_group_chosen и cancel_chosen_group
    """
    all_data = await state.get_data()
    all_chosen_groups = all_data['chosen_groups']

    # Получает список всех групп куда добавлен бот: [ [ [ title , 'group_id'+chat_id ] ], []... ]
    buttons_list = sql_handler.get_groups_list()
    # Здесь хранится новые inline кнопки где показано выбранные до этого группы
    new_buttons_list = []

    for group in buttons_list:
        if group[0][1].replace('group_id', '') in all_chosen_groups:
            chosen_button_name = group[0][0] + ' ✅'
            chosen_button_callback_data = group[0][1].replace('group_id', 'chosen_group_id')
            chosen_button = [[chosen_button_name, chosen_button_callback_data]]

            new_buttons_list.append(chosen_button)
        else:
            new_buttons_list.append(group)

    # Создаем кнопки на основе new_buttons_list
    new_buttons_list.append([['Дальше', 'all_groups_chosen']])

    ready_buttons = button_creator.inline_keyboard_creator(new_buttons_list)

    # Меняем inline кнопку (появится галочка после выбора группы)
    await callback_query.bot.edit_message_reply_markup(
        callback_query.message.chat.id,
        callback_query.message.message_id,
        reply_markup=ready_buttons
    )


async def one_group_chosen(callback_query: types.CallbackQuery, state: FSMContext):
    chosen_group_id = callback_query.data.replace('group_id', '')

    all_data = await state.get_data()

    all_chosen_groups = all_data['chosen_groups']
    all_chosen_groups.append(chosen_group_id)
    await state.update_data(chosen_groups=all_chosen_groups)

    await groups_list_menu(callback_query, state)


async def cancel_chosen_group(callback_query: types.CallbackQuery, state: FSMContext):
    canceled_group_id = callback_query.data.replace('chosen_group_id', '')
    all_data = await state.get_data()

    chosen_groups_list = all_data['chosen_groups']
    new_chosen_groups_list = [i for i in chosen_groups_list if i != canceled_group_id]

    await state.update_data(chosen_groups=new_chosen_groups_list)

    await groups_list_menu(callback_query, state)


async def groups_list_menu_back_button(message: types.Message, state: FSMContext):
    # Онулируем массив chosen_groups возвращаемся назад
    await state.update_data(chosen_groups=[])

    await MyStates.waiting_for_new_timetable_name.set()

    mesg = 'Введите имя расписания:'
    button = button_creator.reply_keyboard_creator([['Назад', 'Главное меню']])

    await message.answer(
        mesg,
        reply_markup=button
    )


async def choise_groups_menu_next_button(callback_query: types.CallbackQuery, state: FSMContext):
    """
    Запустится если пользователь нажал на кнопку дальше после выбора всех нужных групп

    Returns:
        choise_hours_menu
    """

    all_data = await state.get_data()
    chosen_groups_id_list = all_data['chosen_groups']

    # Если пользователь нажал на кнопку дальше не выбрав группы тогда покажем уведомление об этом и остановим функцию
    if not chosen_groups_id_list:
        await callback_query.answer('Пожалуйста выберите группы!')
        return

    # Удаляем inline кнопки список групп
    await callback_query.bot.edit_message_reply_markup(
        callback_query.message.chat.id,
        callback_query.message.message_id
    )

    # Меняем статус на "waiting_for_hours"
    await MyStates.waiting_for_hours.set()

    # Создаем массив "chosen_hours" в state
    await state.update_data(chosen_hours=[])
    # Создаем массив "time" в state. Тут хранится максимум 4 числа, который из-за будем создовать время и добавлять в chosen_hours
    await state.update_data(time=[])

    # Массив с 24 кнопками
    # hours_buttons = button_creator.hours_buttons_list()
    # hours_buttons.append([['Дальше', 'all_hours_chosen']])
    # ready_buttons = button_creator.inline_keyboard_creator(hours_buttons, row_width=4)
    # mesg = 'Выберите время:'
    #
    # await callback_query.bot.send_message(
    #     callback_query.message.chat.id,
    #     mesg,
    #     reply_markup=ready_buttons
    # )

    hours_menu_buttons = button_creator.hours_menu_inline_buttons_creator(
    )
    mesg = '<b>Укажите время (как минимум один):</b>\n\n<b>Выбранное время:</b>\n\n<b>Новое время:</b> ** <b>:</b> **'
    await callback_query.bot.send_message(
        callback_query.message.chat.id,
        mesg,
        reply_markup=hours_menu_buttons,
        parse_mode='html'
    )


async def hours_menu_message_changer(callback_query_or_message: types.CallbackQuery, chosen_hours, time):
    """
    Эту функция запускает hours_menu_buttons_handler при нажатии на числа в меню "hours_menu"
    Функция изменит в сообщении "** : **"
    Args:
        callback_query_or_message:
        chosen_hours: [['14', '53'], ...] - например первый массив это 14:53
        time: массив, в котором хранится максимум 4 числа и мы тут изменим сообщение(**:**) исходя из этих чисел
    Returns:
    """

    mesg1 = '<b>Укажите время (как минимум один):</b>\n\n'

    str_time_list = []
    # Составляем время в виде str(13:23) из массива chosen_hours. Там может быть несколько
    for t in chosen_hours:
        just_str = ''.join(t)
        str_time = just_str[:2] + ':' + just_str[2:]

        str_time_list.append(str_time)

    # Составим сообщение: Выбранное время: 15:12, 05:15
    mesg2 = '<b>Выбранное время:</b> ' + ', '.join(str_time_list) + '\n\n'

    mesg3 = '<b>Новое время:</b> ** <b>:</b> **'
    # Вместо * поставим числа который уже выбраны
    for i in time:
        mesg3 = mesg3.replace('*', i, 1)

    mesg = mesg1 + mesg2 + mesg3

    hours_menu_buttons = button_creator.hours_menu_inline_buttons_creator()

    # Если оказался в меня из предедущего
    try:
        await callback_query_or_message.bot.edit_message_text(
            text=mesg,
            chat_id=callback_query_or_message.from_user.id,
            message_id=callback_query_or_message.message.message_id,
            reply_markup=hours_menu_buttons,
            parse_mode='html'
        )
    # Если вернулся назад из следующего меню
    except:
        await callback_query_or_message.bot.send_message(
            chat_id=callback_query_or_message.chat.id,
            text=mesg,
            reply_markup=hours_menu_buttons,
            parse_mode='html'
        )


async def hours_menu_buttons_handler(callback_query: types.CallbackQuery, state: FSMContext):
    """
    Запустится после того как пользователь нажмет на кнопку: 0-9, ⬅️(backspace), 🆗(time_chosen), Дальше
    Args:
        callback_query:
        state:
    Returns:
    """
    all_data = await state.get_data()
    chosen_hours = all_data['chosen_hours']
    time = all_data['time']

    pressed_button = callback_query.data.replace('t_', '')

    # Если нажал на кнопку 0-9
    if pressed_button.isdigit():
        # Если еще не указал 4 числа(**:**), тогда добавим выбранное число в массив time и изменим сообщение(05:**)
        if len(time) < 4:
            time.append(pressed_button)
            # Сохраним выбранное число в массиве
            await state.update_data(time=time)

            # Изменим сообщение(**:**)
            await hours_menu_message_changer(callback_query, chosen_hours, time)

    # Если нажал на ⬅️(backspace), то удалим последний элемент из time и изменим сообщение
    elif pressed_button == 'backspace':
        # Если time не пустой, то удалим последний элемент. Если пустой но ничего не будем делать
        if time:
            time.pop()

            # Сохраним выбранное число в массиве
            await state.update_data(time=time)

            # Изменим сообщение(**:**)
            await hours_menu_message_changer(callback_query, chosen_hours, time)

    # Если нажал на 🆗, тогда проверим указанное время, если все правильно то добавим его в массив chosen_hours
    # Если время не правильно указано или в массиве time не 4 элементов, тогда сообщим об ошибке
    elif pressed_button == 'time_chosen':
        # Если указано 4 числа, тогда проверим время и если указано правильное время, тогда добавим его в chosen_hours
        if len(time) == 4:
            hour = ''.join(time[:2])
            minute = ''.join(time[2:])

            # Если время указано правильно
            if 0 <= int(hour) < 24 and 0 <= int(minute) < 60:
                chosen_hours.append([hour, minute])

                # Сохраним новый chosen_hours в state
                await state.update_data(chosen_hours=chosen_hours)

                # Аннулируем time
                time = []
                await state.update_data(time=time)

                # Изменим сообщение
                await hours_menu_message_changer(callback_query, chosen_hours, time)

            # Если неправильно указано время
            else:
                mesg = 'Время указано неправильно!'

                await callback_query.answer(mesg)

        # Если админ нажал на 🆗 не указав 4 чисел, тогда сообщим об ошибке
        else:
            mesg = 'Время указано неправильно!'

            await callback_query.answer(mesg)

    # Если нажал на Дальше, проверим указал ли хотябы одно время(chosen_hours), если да то перейдем на следующий меню
    elif pressed_button == 'all_hours_chosen':
        if chosen_hours:
            # Меняем статус на waiting_for_mailing_text
            await MyStates.waiting_for_mailing_message_photo_caption.set()

            # Составим текст сообщения
            # В chosen_hours хранится: [['12', '34'], ...]. А мы создадим из них '12:34, 23:01, ...' и запишем в базу
            chosen_hours_str = ''
            for time in chosen_hours:
                chosen_hours_str += time[0] + ':' + time[1] + ', '
            mesg1 = f'<b>Список времени:</b> ' + chosen_hours_str.rstrip(', ')
            mesg2 = '<b>Отравьте текст сообщения рассылки:</b>'
            mesg = mesg1 + '\n\n' + mesg2

            reply_buttons_list = [['Назад', 'Главное меню']]
            reply_buttons = button_creator.reply_keyboard_creator(reply_buttons_list)
            await callback_query.bot.send_message(
                callback_query.message.chat.id,
                mesg,
                reply_markup=reply_buttons,
                parse_mode='html'
            )

        # Если не указал ни одно время, то сообщим об ошибке
        else:
            mesg = 'Пожалуйста укажите хотя-бя одно время'

            await callback_query.answer(mesg)


async def choise_hours_menu_back_button(message: types.Message, state: FSMContext):
    await state.update_data(chosen_hours=[])
    await state.update_data(time=[])

    await timetable_name_chosen(message, state)


# # # Get mailing message photo(caption) system
async def mailing_photo_caption_given(message: types.Message, state: FSMContext):
    """
    Запустится после того как пользователь отправил фото сообщения рассылки
    Returns:
        Сколько дней нужно отправлять сообщение. Укажите цифру в диапазоне от 1 до 100):
    """
    photo = message.photo[-1]
    caption = message.caption

    # Запищем отправленный фото и его описание в state
    await state.update_data(mailing_photo=photo)
    await state.update_data(mailing_video=None)
    await state.update_data(mailing_caption=caption)

    # Меняем статус
    await MyStates.waiting_for_term.set()

    mesg = 'Сколько дней нужно отправлять сообщение. Укажите цифру в диапазоне от 1 до 100:'
    reply_buttons_list = [['Назад', 'Главное меню']]
    reply_buttons = button_creator.reply_keyboard_creator(reply_buttons_list)

    await message.answer(mesg, reply_markup=reply_buttons)


# # # Get mailing message text system
async def mailing_text_given(message: types.Message, state: FSMContext):
    """
    Запустится после того как пользователь отправил текст сообщения рассылки
    Returns:
        Сколько дней нужно отправлять сообщение. Укажите цифру в диапазоне от 1 до 100):
    """
    caption = message.text

    # Запищем отправленный фото и его описание в state
    await state.update_data(mailing_photo=None)
    await state.update_data(mailing_video=None)
    await state.update_data(mailing_caption=caption)

    # Меняем статус
    await MyStates.waiting_for_term.set()

    mesg = 'Сколько дней нужно отправлять сообщение. Укажите цифру в диапазоне от 1 до 100:'
    reply_buttons_list = [['Назад', 'Главное меню']]
    reply_buttons = button_creator.reply_keyboard_creator(reply_buttons_list)

    await message.answer(mesg, reply_markup=reply_buttons)


async def mailing_video_given(message: types.Message, state: FSMContext):
    """
    Запустится после того как пользователь отправил видео рассылки
    Returns:
        Сколько дней нужно отправлять сообщение. Укажите цифру в диапазоне от 1 до 100):
    """
    caption = message.caption

    # Запищем отправленный фото и его описание в state
    await state.update_data(mailing_photo=None)
    await state.update_data(mailing_video=message.video.file_id)
    await state.update_data(mailing_caption=caption)

    # Меняем статус
    await MyStates.waiting_for_term.set()

    mesg = 'Сколько дней нужно отправлять сообщение. Укажите цифру в диапазоне от 1 до 100:'
    reply_buttons_list = [['Назад', 'Главное меню']]
    reply_buttons = button_creator.reply_keyboard_creator(reply_buttons_list)

    await message.answer(mesg, reply_markup=reply_buttons)


async def mailing_message_text_back_button(message: types.Message, state: FSMContext):
    # Меняем статус на "waiting_for_hours"
    await MyStates.waiting_for_hours.set()

    all_data = await state.get_data()
    chosen_hours = all_data['chosen_hours']
    time = all_data['time']

    await hours_menu_message_changer(message, chosen_hours, time)


# # # Get term system
async def term_given(message: types.Message, state: FSMContext):
    """
    Запустится если пользователь указал сколько дней нужно отправлять рассылку
    Returns:
    """
    term = message.text

    if term.isdigit():
        term = int(term)
        if 0 < term <= 100:
            await process_data(message, state)
        else:
            mesg = 'Укажите цифру в диапазоне от 1 до 100'
            await message.answer(mesg)
            return
    else:
        mesg = 'Укажите целое число'
        await message.answer(mesg)
        return


async def term_menu_back_button(message: types.Message, state: FSMContext):
    await state.update_data(mailing_photo='')
    await state.update_data(mailing_caption='')

    # Меняем статус на waiting_for_mailing_text
    await MyStates.waiting_for_mailing_message_photo_caption.set()

    mesg = 'Отравьте текст сообщения рассылки:'
    reply_buttons_list = [['Назад', 'Главное меню']]
    reply_buttons = button_creator.reply_keyboard_creator(reply_buttons_list)
    await message.answer(
        mesg,
        reply_markup=reply_buttons
    )


async def process_data(message: types.Message, state: FSMContext):
    all_data = await state.get_data()

    timetable_id = sql_handler.timetable_id_generator()

    # Если отправил фотографию для рассылки:
    if all_data['mailing_photo']:
        destination_file = 'images/'+timetable_id+'.jpg'
        await all_data['mailing_photo'].download(destination_file=destination_file)

        if not all_data['mailing_caption']:
            text = '.'
        else:
            text = all_data['mailing_caption']

        video_id = None

    # Если отправил видео для рассылки:
    elif all_data['mailing_video']:
        destination_file = None

        if not all_data['mailing_caption']:
            text = '.'
        else:
            text = all_data['mailing_caption']

        video_id = all_data['mailing_video']

    # Если отправил текст для рассылки:
    else:
        text = all_data['mailing_caption']
        video_id = None
        destination_file = None

    ready_data = {
        'timetable_id': timetable_id,
        'timetable_name': all_data['timetable_name'],
        'chosen_groups': ','.join(all_data['chosen_groups']),
        # В chosen_hours хранится: [['12', '34'], ...]
        'chosen_hours': all_data['chosen_hours'],
        # 'mailing_photo': all_data['mailing_message_text'],
        'mailing_caption': text,
        'term': datetime.date.today() + datetime.timedelta(days=int(message.text)),
        'mailing_photo': destination_file,
        'video_id': video_id,
        'admin_chat_id': message.from_user.id
    }

    # Закрываем все статусы
    await state.finish()

    # Записываем полученные данные в базу данных
    sql_handler.ready_data_handler(ready_data)

    # Записываем на cron
    cron_handler.new_job_creator(ready_data)

    # Отправим сообщение о том что расписание успешно сохранилась
    mesg = '✅ Данные сохранены. Можно увидеть подробно в меню "Список расписаний"'
    button = button_creator.reply_keyboard_creator([['Главное меню']])

    await message.answer(mesg, reply_markup=button)


# # # 3-menu) Delete timetable
async def delete_timetable_menu(callback_query: types.CallbackQuery, state: FSMContext):
    # Удаляем inline кнопки меню главного меню
    await callback_query.bot.edit_message_reply_markup(
        callback_query.message.chat.id,
        callback_query.message.message_id
    )

    mesg = 'Выберите расписание который хотите удалить:'

    buttons_list = sql_handler.get_timetable_list_for_delete()
    ready_buttons = button_creator.inline_keyboard_creator(buttons_list)

    await callback_query.bot.send_message(
        callback_query.from_user.id,
        mesg,
        reply_markup=ready_buttons
    )


async def confirm_delete_chosen_timetable(callback_query: types.CallbackQuery, state: FSMContext):
    timetable_id_for_delete = callback_query.data.replace('chosen_timetable_id_for_delete', '')

    # Удаляем inline кнопки меню "Удалить расписание"
    await callback_query.bot.edit_message_reply_markup(
        callback_query.message.chat.id,
        callback_query.message.message_id
    )

    timetable_title = sql_handler.get_timetable_title(timetable_id_for_delete)
    mesg = f'Вы выбрали <b>{timetable_title}</b>\nВы действительно хотите удалить расписание?'

    buttons_list = [[['Да', f'yes_delete{timetable_id_for_delete}'], ['Нет', 'back_to_delete_timetable_menu']]]
    ready_button = button_creator.inline_keyboard_creator(buttons_list)

    await callback_query.bot.send_message(
        callback_query.from_user.id,
        mesg,
        reply_markup=ready_button,
        parse_mode='html'
    )


async def delete_chosen_timetable(callback_query: types.CallbackQuery, state: FSMContext):
    timetable_id_for_delete = callback_query.data.replace('yes_delete', '')

    # Удаляем inline кнопки Подтверждения (да нет)
    await callback_query.bot.edit_message_reply_markup(
        callback_query.message.chat.id,
        callback_query.message.message_id
    )

    # Удаляем из базы
    sql_handler.delete_timetable(timetable_id_for_delete)
    # Удаляем из cron
    cron_handler.job_deletor_by_comment(timetable_id_for_delete)

    # Отправим всплывающее окно
    await callback_query.answer('Расписание успешно удалено!')

    # Вернем главное меню
    await admin_panel_menu(callback_query, state)


# # # Settings menu
async def settings_menu(callback_query: types.CallbackQuery, state: FSMContext):
    mesg = 'Настройки:'
    buttons = [[['Изменить пароль', 'change_password'], ['Связь с разработчиком', 'support']]]
    ready_buttons = button_creator.inline_keyboard_creator(buttons, row_width=2)

    # Меняем статут на setting_menu чтобы работала кнопка "Назад"
    await MyStates.settings_menu.set()

    await callback_query.bot.edit_message_reply_markup(
        callback_query.message.chat.id,
        callback_query.message.message_id
    )

    await callback_query.bot.send_message(
        callback_query.from_user.id,
        mesg,
        reply_markup=ready_buttons
    )


async def change_password_button_handler(callback_query: types.CallbackQuery, state: FSMContext):
    mesg = 'Введите новый пароль:'
    button = button_creator.reply_keyboard_creator([['Главное меню']])

    await MyStates.waiting_for_new_password.set()

    # Удаляем инлайн кнопки предыдущого меню
    await callback_query.bot.edit_message_reply_markup(
        callback_query.message.chat.id,
        callback_query.message.message_id
    )

    await callback_query.bot.send_message(
        callback_query.from_user.id,
        mesg,
        reply_markup=button
    )


async def new_password_chosen(message: types.Message, state: FSMContext):
    new_password = message.text

    if len(new_password) > 32:
        button = button_creator.reply_keyboard_creator([['Назад', 'Главное меню']])
        mesg = '❌ Слищком длинный пароль! Попробуйте еще раз'
        await message.answer(mesg, reply_markup=button)
        return
    elif len(new_password) < 4:
        button = button_creator.reply_keyboard_creator([['Назад', 'Главное меню']])
        mesg = '❌ Слищком короткий пароль! Попробуйте еще раз'
        await message.answer(mesg, reply_markup=button)
        return

    sql_handler.change_password(new_password)

    # Отключаем статус
    await state.finish()

    button = button_creator.reply_keyboard_creator([['Главное меню']])
    mesg = '✅ Пароль успешно изменен'
    await message.answer(mesg, reply_markup=button)


async def support_button_handler(callback_query: types.CallbackQuery, state: FSMContext):
    # Удаляем инлайн кнопки предыдущого меню
    await callback_query.bot.edit_message_reply_markup(
        callback_query.message.chat.id,
        callback_query.message.message_id
    )

    await state.finish()

    mesg = sql_handler.get_data_from_data_table('support')
    button = button_creator.reply_keyboard_creator([['Главное меню']])

    await callback_query.bot.send_message(
        callback_query.message.chat.id,
        mesg,
        reply_markup=button
    )


# # #
def register_handlers_admin_panel(dp: Dispatcher):
    dp.register_message_handler(
        admin_panel,
        commands=['admin'],
        state='*'
    )

    dp.register_message_handler(
        password_checker,
        state=MyStates.waiting_for_password
    )

    dp.register_message_handler(
        admin_panel_menu,
        lambda message: message.text == 'Главное меню' and message.chat.type == 'private',
        state='*'
    )

    dp.register_callback_query_handler(
        timetable_list_handler,
        lambda c: c.data == 'timetable_list'
    )

    dp.register_callback_query_handler(
        show_info_about_timetable,
        lambda c: c.data.startswith('timetable_id')
    )

    dp.register_callback_query_handler(
        admin_panel_menu,
        lambda c: c.data == 'admin_panel_menu'
    )

    dp.register_callback_query_handler(
        add_new_timetable_menu,
        lambda c: c.data == 'add_new_timetable'
    )

    dp.register_message_handler(
        timetable_name_menu_back_button,
        lambda message: message.text == 'Назад',
        state=MyStates.waiting_for_new_timetable_name
    )

    dp.register_message_handler(
        timetable_name_chosen,
        state=MyStates.waiting_for_new_timetable_name
    )

    dp.register_callback_query_handler(
        one_group_chosen,
        lambda c: c.data.startswith('group_id'),
        state=MyStates.waiting_for_groups
    )

    dp.register_callback_query_handler(
        cancel_chosen_group,
        lambda c: c.data.startswith('chosen_group_id'),
        state=MyStates.waiting_for_groups
    )

    dp.register_callback_query_handler(
        choise_groups_menu_next_button,
        lambda c: c.data == 'all_groups_chosen',
        state=MyStates.waiting_for_groups
    )

    dp.register_message_handler(
        groups_list_menu_back_button,
        lambda message: message.text == 'Назад',
        state=MyStates.waiting_for_groups
    )

    dp.register_callback_query_handler(
        hours_menu_buttons_handler,
        lambda c: c.data.startswith('t_'),
        state=MyStates.waiting_for_hours
    )

    dp.register_message_handler(
        choise_hours_menu_back_button,
        lambda message: message.text == 'Назад',
        state=MyStates.waiting_for_hours
    )
    #
    # dp.register_callback_query_handler(
    #     choise_hours_menu_next_button,
    #     lambda c: c.data == 'all_hours_chosen',
    #     state=MyStates.waiting_for_hours
    # )

    dp.register_message_handler(
        mailing_message_text_back_button,
        lambda message: message.text == 'Назад',
        state=MyStates.waiting_for_mailing_message_photo_caption
    )

    dp.register_message_handler(
        mailing_photo_caption_given,
        content_types=['photo'],
        state=MyStates.waiting_for_mailing_message_photo_caption
    )

    # Если админ вместо фотки с описанием рекламы отправил видео
    dp.register_message_handler(
        mailing_video_given,
        content_types=['video'],
        state=MyStates.waiting_for_mailing_message_photo_caption
    )

    # Если админ вместо фотки с описанием рекламы отправил только текст
    dp.register_message_handler(
        mailing_text_given,
        content_types=['text'],
        state=MyStates.waiting_for_mailing_message_photo_caption
    )

    dp.register_message_handler(
        term_menu_back_button,
        lambda message: message.text == 'Назад',
        state=MyStates.waiting_for_term
    )

    dp.register_message_handler(
        term_given,
        state=MyStates.waiting_for_term
    )

    dp.register_callback_query_handler(
        delete_timetable_menu,
        lambda c: c.data == 'delete_timetable'
    )

    dp.register_callback_query_handler(
        confirm_delete_chosen_timetable,
        lambda c: c.data.startswith('chosen_timetable_id_for_delete')
    )

    dp.register_callback_query_handler(
        delete_chosen_timetable,
        lambda c: c.data.startswith('yes_delete')
    )

    dp.register_callback_query_handler(
        settings_menu,
        lambda c: c.data == 'settings'
    )

    dp.register_message_handler(
        admin_panel_menu,
        lambda message: message.text == 'Назад',
        state=MyStates.settings_menu
    )

    dp.register_callback_query_handler(
        change_password_button_handler,
        lambda c: c.data == 'change_password',
        state=MyStates.settings_menu
    )

    dp.register_message_handler(
        new_password_chosen,
        state=MyStates.waiting_for_new_password
    )

    dp.register_callback_query_handler(
        support_button_handler,
        lambda c: c.data == 'support',
        state=MyStates.settings_menu
    )
