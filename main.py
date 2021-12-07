import logging
import aiogram.types.reply_keyboard
from aiogram import Bot, Dispatcher, executor, types
from aiogram.contrib.fsm_storage.memory import MemoryStorage

import sql_handler
import admin_panel

API_TOKEN = '5073184755:AAFXBB0aNhKDlCCppiLxIwgL7mGyRAyfyZY'

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


@dp.message_handler(commands=['asssss'])
async def send_message(message: types.Message):
    await message.answer(message)


@dp.message_handler(commands=['test'])
async def send_info(message: types.Message):
    await message.answer(message)


if __name__ == '__main__':
    admin_panel.register_handlers_admin_panel(dp)

    executor.start_polling(dp, skip_updates=True)
