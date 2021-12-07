from aiogram import Dispatcher, types
from aiogram.dispatcher import FSMContext
from aiogram.dispatcher.filters.state import State, StatesGroup
import sql_handler
import button_creator

class MyStates(StatesGroup):
    waiting_for_password = State()
    waiting_for_new_timetable_name = State()


async def admin_panel(message: types.Message, state: FSMContext):
    await state.finish()

    if message.chat.type == 'private':
        msg = 'Введите пароль:'

        await MyStates.waiting_for_password.set()
        await message.answer(msg)


async def admin_panel_menu(message_or_callback_query, state: FSMContext):
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

    button = button_creator.reply_keyboard_creator([['Назад']])

    await callback_query.bot.send_message(
        callback_query.from_user.id,
        mesg,
        reply_markup=button
    )

    await MyStates.waiting_for_new_timetable_name.set()


async def waiting_for_timetable_name(message: types.Message, state: FSMContext):
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

    dp.message_handler(
        waiting_for_timetable_name,
        state=MyStates.waiting_for_new_timetable_name
    )