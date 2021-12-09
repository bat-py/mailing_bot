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


@dp.message_handler(commands=['start', 'help'])
async def send_message(message: types.Message):
    if message.chat.type == 'group' or message.chat.type == 'supergroup':
        chats_list = sql_handler.get_chats_id_list()

        # Если ид группы не найдено из базы тогда он добавит его в таблицу 'groups'
        if message.chat.id not in chats_list:
            sql_handler.add_new_chat(message)
            await message.answer('Your group added :)')
        else:
            sql_handler.del_group(message.chat.id)
            sql_handler.add_new_chat(message)
            await message.answer('Your group updated :)')
    elif message.chat.type == 'private':
        mesg = sql_handler.get_data_from_data_table('start_button_response_in_private')

        await message.answer(mesg)


@dp.message_handler(content_types=['photo'])
async def send_info(message: types.Message):
    await message.answer(message)



if __name__ == '__main__':
    admin_panel.register_handlers_admin_panel(dp)

    executor.start_polling(dp, skip_updates=True)
