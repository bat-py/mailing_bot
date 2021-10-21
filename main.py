import logging

import aiogram.types.reply_keyboard
from aiogram import Bot, Dispatcher, executor, types

API_TOKEN = '1018761895:AAE9zGMHZxYZlC_6kyRLAmTBC0Oubpp-QUQ'

# Configure logging
logging.basicConfig(level=logging.INFO)

# Initialize bot and dispatcher
bot = Bot(token=API_TOKEN)
dp = Dispatcher(bot)


@dp.message_handler(commands=['start', 'help'])
async def send_message(message: types.Message):
    button1 = aiogram.types.reply_keyboard.KeyboardButton('1 bot')
    button2 = aiogram.types.reply_keyboard.KeyboardButton('2 bot')
    buttons = aiogram.types.reply_keyboard.ReplyKeyboardMarkup(keyboard=[[button1, button2]], resize_keyboard=True)

    await message.answer("Choise your bot", reply_markup=buttons)


@dp.message_handler(lambda message: message.text == 'tilla')
async def send_message(message: types.Message):
    await message.answer('Mirkosh chumo')


if __name__ == '__main__':
    executor.start_polling(dp, skip_updates=True)