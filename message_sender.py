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



async def main():
    timetable_id = sys.argv[1]
    # Gets (groups_id_list, mailing_text, mailing_image)
    data = sql_handler.get_groups_id_mailing_text_image(timetable_id)


    for group_id in data[0]:
        try:
            if data[2]:
                photo = open(data[2], 'rb')
                print(group_id)

                if data[1] == '.':
                    await bot.send_photo(group_id, photo=photo)
                else:
                    await bot.send_photo(group_id, photo=photo, caption=data[1])
            else:
                await bot.send_message(group_id, text=data[1])

            await asyncio.sleep(2)

        except Exception as e:
            with open('errors.txt', 'a', encoding='utf-8') as w:
                w.write('\n\n'+str(e)+' '+str(timetable_id))


if __name__ == '__main__':
    errors = 0

    while True:
        try:
            # Initialize bot and dispatcher
            bot = Bot(token=API_TOKEN)
            storage = MemoryStorage()
            dp = Dispatcher(bot, storage=storage)
            
            loop = asyncio.get_event_loop()
            loop.run_until_complete(main())
            loop.close()
            break
        except:
            if errors == 10:
                break
            time.sleep(10)
        errors += 1

