import logging
import aiogram.types.reply_keyboard
from aiogram import Bot, Dispatcher, executor, types
from aiogram.contrib.fsm_storage.memory import MemoryStorage
import configparser
import sql_handler
import admin_panel
from apscheduler.schedulers.asyncio import AsyncIOScheduler

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


#@dp.message_handler(content_types=['photo'])
#async def send_info(message: types.Message):
#    await message.answer(message.caption)


async def check_ad_terms(dp: Dispatcher):
    """
    Отправит админу создавший рекламу о том что срок закончился
    Args:
        dp:
    Returns:
    """
    # Получит ((timetable_id,timetable_name, groups_id, hours, mailing_text, term, images, video_id, admin_chat_id),...)
    # Или может получить пустой массив. Если получит пустой, то ничего делать не будем
    expired_ads = sql_handler.get_expired_ads()

    if expired_ads:
        for ad_ in expired_ads:
            admin_chat_id = ad_['admin_chat_id']
            timetable_name = ad_['timetable_name']

            msg = f'📥 Уведомление \n\nСегодня последний день рекламы <b>{timetable_name}</b>'

            await dp.bot.send_message(
                admin_chat_id,
                msg,
                parse_mode='html'
            )


async def schedule_jobs(dp: Dispatcher):
    scheduler.add_job(check_ad_terms, 'cron', hour=0, minute=0, args=(dp, ))


if __name__ == '__main__':
    admin_panel.register_handlers_admin_panel(dp)

    scheduler = AsyncIOScheduler()
    scheduler.start()

    executor.start_polling(dp, skip_updates=True, on_startup=schedule_jobs)
