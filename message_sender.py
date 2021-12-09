import asyncio
import logging
from aiogram import Bot, Dispatcher, executor, types
from aiogram.contrib.fsm_storage.memory import MemoryStorage
import sys
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
    # Gets (groups_id_list, mailing_text)
    data = sql_handler.get_groups_id_mailing_text(timetable_id)

    for group_id in data[0]:
        await bot.send_message(group_id, data[1])
        time.sleep(1)


if __name__ == '__main__':
    asyncio.run(main())
