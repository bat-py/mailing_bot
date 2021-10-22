import logging
import pymysql
import aiogram.types.reply_keyboard
from aiogram import Bot, Dispatcher, executor, types
from pymysql.cursors import DictCursor

API_TOKEN = '1018761895:AAE9zGMHZxYZlC_6kyRLAmTBC0Oubpp-QUQ'

# Configure logging
logging.basicConfig(level=logging.INFO)

# Initialize bot and dispatcher
bot = Bot(token=API_TOKEN)
dp = Dispatcher(bot)


def connection_creator():
    connection = pymysql.connect(
        host='archlinux.uz',
        user='crow',
        password='ifuckyou',
        db='tilla_ads',
        charset='utf8mb4',
        cursorclass=DictCursor
    )

    return connection


@dp.message_handler(commands=['start', 'help'])
async def send_message(message: types.Message):
    button1 = aiogram.types.reply_keyboard.KeyboardButton('1 bot')
    button2 = aiogram.types.reply_keyboard.KeyboardButton('2 bot')
    buttons = aiogram.types.reply_keyboard.ReplyKeyboardMarkup(keyboard=[[button1, button2]],
                                                               resize_keyboard=True)

    await message.answer("Choise your bot", reply_markup=buttons)


@dp.message_handler(lambda message: message.text == '1 bot' or message.text == '2 bot')
async def send_message(message: types.Message):
    button1 = aiogram.types.reply_keyboard.KeyboardButton('Message')
    button2 = aiogram.types.reply_keyboard.KeyboardButton('Groups')
    button3 = aiogram.types.reply_keyboard.KeyboardButton('On/Off')
    buttons = aiogram.types.reply_keyboard.ReplyKeyboardMarkup(keyboard=[[button1, button2, button3]],
                                                               resize_keyboard=True)

    await message.answer('Choose menu', reply_markup=buttons)


@dp.message_handler(lambda message: message.text == 'Groups')
async def send_message(message: types.Message):
    button1 = aiogram.types.reply_keyboard.KeyboardButton('Groups list')
    button2 = aiogram.types.reply_keyboard.KeyboardButton('Add')
    button3 = aiogram.types.reply_keyboard.KeyboardButton('Delete')
    buttons = aiogram.types.reply_keyboard.ReplyKeyboardMarkup(keyboard=[[button1, button2, button3]],
                                                               resize_keyboard=True)

    await message.answer('Choose command', reply_markup=buttons)


@dp.message_handler(lambda message: message.text == 'Groups list')
async def send_message(message: types.Message):



if __name__ == '__main__':
    executor.start_polling(dp, skip_updates=True)