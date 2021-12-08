from aiogram import Dispatcher, types
from aiogram.dispatcher import FSMContext
from aiogram.dispatcher.filters.state import State, StatesGroup
import sql_handler
import button_creator


class MyStates(StatesGroup):
    waiting_for_password = State()
    waiting_for_new_timetable_name = State()
    waiting_for_groups = State()
    waiting_for_hours = State()


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


async def timetable_list_handler(callback_query: types.CallbackQuery, state: FSMContext):
    # Вернет [ [ [button_name, 'button_id1216546'] ], [], [] ]
    timetable_list = sql_handler.get_timetable_list()
    timetable_list.append([['Назад', 'admin_panel_menu']])

    mesg = 'Список расписаний:'
    inline_buttons = button_creator.inline_keyboard_creator(timetable_list)

    await callback_query.bot.send_message(
        callback_query.from_user.id,
        mesg,
        reply_markup=inline_buttons
    )


async def add_new_timetable_menu(callback_query: types.CallbackQuery, state: FSMContext):
    mesg = 'Введите имя расписания:'
    button = button_creator.reply_keyboard_creator([['Назад'], ['Главное меню']])

    # Удаляем inline кнпоки главного меню
    await callback_query.bot.edit_message_reply_markup(
        callback_query.message.chat.id,
        callback_query.message.message_id,
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
    if message.text == 'Назад':
        await state.finish()
        await admin_panel_menu(message, state)
        return

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


# Choise groups menu system:
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

    # Массив с 24 кнопками
    hours_buttons = button_creator.hours_buttons_list()
    hours_buttons.append([['Дальше', 'all_hours_chosen']])
    ready_buttons = button_creator.inline_keyboard_creator(hours_buttons, row_width=4)
    mesg = 'Выберите время:'

    await callback_query.bot.send_message(
        callback_query.message.chat.id,
        mesg,
        reply_markup=ready_buttons
    )


# Choise hours menu system:
async def choise_hours_menu(callback_query: types.CallbackQuery, state: FSMContext):
    """
    Returns:
        Вернет 24кнопки часов если до этого выбрал пользователь какой-то время тогда поставит ✅ и изменит callback_data
    """
    all_data = await state.get_data()
    # Массив с 24 кнопками
    hours_buttons = button_creator.hours_buttons_list()

    # Выбранные часы:
    chosen_hours = all_data['chosen_hours']

    ready_hours = []
    for hour_row in hours_buttons:
        new_row = []
        for hour in hour_row:
            if hour[1].replace('hour', '') in chosen_hours:
                chosen_hour_button_name = hour[0]+' ✅'
                chosen_hour_button_callback_data = hour[1].replace('hour', 'chosen_hour')
                chosen_hour = [chosen_hour_button_name, chosen_hour_button_callback_data]
                new_row.append(chosen_hour)
            else:
                new_row.append(hour)

        ready_hours.append(new_row)

    # Добавим кнопку дальше
    ready_hours.append([['Дальше', 'all_hours_chosen']])
    # Создаем кнопки на основе ready_hours
    ready_hours_buttons = button_creator.inline_keyboard_creator(ready_hours, row_width=4)

    # Изменим уже существующий inline кнопки на основе новых кнопок
    await callback_query.bot.edit_message_reply_markup(
        callback_query.message.chat.id,
        callback_query.message.message_id,
        reply_markup=ready_hours_buttons
    )


async def one_hour_chosen(callback_query: types.CallbackQuery, state: FSMContext):
    """
    Запускается после того как пользователь выбрал какой-то час. Добавит выбранный час в массив chosen_hours и
    запустит функцию choise_hours_menu
    """
    chosen_hour = callback_query.data.replace('hour', '')

    all_data = await state.get_data()
    chosen_hours = all_data['chosen_hours']

    if chosen_hour not in chosen_hours:
        chosen_hours.append(chosen_hour)

    await state.update_data(chosen_hours=chosen_hours)

    await choise_hours_menu(callback_query, state)


async def cancel_chosen_hour(callback_query: types.CallbackQuery, state: FSMContext):
    """
    Запустится если пользователь выбрал уже выбранный час(то есть отменил). Удалит этот час из массива chosen_hours и
    запустит фукнцию choise_hours_menu
    """
    canceled_hour = callback_query.data.replace('chosen_hour', '')

    all_data = await state.get_data()
    chosen_hours = all_data['chosen_hours']

    new_chosen_hours = [i for i in chosen_hours if i != canceled_hour]

    await state.update_data(chosen_hours=new_chosen_hours)

    await choise_hours_menu(callback_query, state)


async def choise_hours_menu_next_button(callback_query: types.CallbackQuery, state: FSMContext):
    pass


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
        lambda message: message.text == 'Главное меню',
        state='*'
    )

    dp.register_callback_query_handler(
        timetable_list_handler,
        lambda c: c.data == 'timetable_list'
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

    dp.register_callback_query_handler(
        one_hour_chosen,
        lambda c: c.data.startswith('hour'),
        state=MyStates.waiting_for_hours
    )

    dp.register_callback_query_handler(
        cancel_chosen_hour,
        lambda c: c.data.startswith('chosen_hour'),
        state=MyStates.waiting_for_hours
    )

    dp.register_callback_query_handler(
        choise_hours_menu_next_button,
        lambda c: c.data == 'all_hours_chosen',
        state=MyStates.waiting_for_hours
    )