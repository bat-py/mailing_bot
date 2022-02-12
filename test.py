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