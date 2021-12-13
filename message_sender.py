import asyncio
import logging
from aiogram import Bot, Dispatcher, executor, types
from aiogram.contrib.fsm_storage.memory import MemoryStorage
import sys
import os
from aiogram.types import InputFile

import sql_handler
import time
import configparser

config = configparser.ConfigParser()
config.read('config.ini')
API_TOKEN = config['main']['api_token']

# Configure logging
logging.basicConfig(level=logging.INFO)

# Initialize bot and dispatcher
bot = Bot(token=API_TOKEN)
storage = MemoryStorage()
dp = Dispatcher(bot, storage=storage)


async def main():
    timetable_id = sys.argv[1]
    # Gets (groups_id_list, mailing_text, mailing_image)
    data = sql_handler.get_groups_id_mailing_text_image(timetable_id)


    for group_id in data[0]:
        try:
            photo = open(data[2], 'rb')
            print(group_id)
            await bot.send_photo(group_id, photo=photo, caption=data[1])
            await asyncio.sleep(2)

        except Exception as e:
            with open('errors.txt', 'a', encoding='utf-8') as w:
                w.write('\n\n'+str(e))


if __name__ == '__main__':
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())