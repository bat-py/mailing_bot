import logging
import aiogram.types.reply_keyboard
from aiogram import Bot, Dispatcher, executor, types
from aiogram.contrib.fsm_storage.memory import MemoryStorage
import configparser
import sql_handler
import admin_panel

config = configparser.ConfigParser()
config.read('config.ini')
API_TOKEN = config['main']['api_token']

# Configure logging
logging.basicConfig(level=logging.INFO)

# Initialize bot and dispatcher
bot = Bot(token=API_TOKEN)
storage = MemoryStorage()
dp = Dispatcher(bot, storage=storage)

@dp.message_handler(content_types=['video'])
async def data_return(message: types.Message):
    await message.answer(message.video.file_id)


@dp.message_handler(lambda mesg: mesg.text == 'hello')
async def nothing(message: types.Message):
    await bot.send_video(message.chat.id, 'BAACAgIAAxkBAAIjeWIH-liUu3Gcmfn5sL-j5eo5_huQAAI1FQAC0i5BSJr63PDVF07oIwQ')



if __name__ == '__main__':
    executor.start_polling(dp, skip_updates=True)






# # # Choise hours menu system:
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
                chosen_hour_button_name = hour[0] + ' ✅'
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
    try:
        await callback_query.bot.edit_message_reply_markup(
            callback_query.message.chat.id,
            callback_query.message.message_id,
            reply_markup=ready_hours_buttons
        )
    # Если эту функцию запустил кнопка назад предыдущего меню, тогда запустится эта часть
    except:
        mesg = 'Выберите время:'

        await callback_query.bot.send_message(
            callback_query.chat.id,
            mesg,
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