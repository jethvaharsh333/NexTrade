# class Config:
#     JWT_SECRET_KEY = "sdgfijjh3466iu345g87g08c24g7204gr803g30587ghh35807fg39074fvg80493745gf082b507807g807fgf"  # Must match .NET Core JWT signing key
#     JWT_ALGORITHM = "HS256"

from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv()

JWT_SECRET_KEY = os.getenv('JWT_SECRET_KEY')
JWT_ALGORITHM = os.getenv('JWT_ALGORITHM')

CSV_FILE_PATH = os.getenv('CSV_FILE_PATH')
NSE_CSV_URL = os.getenv('NSE_CSV_URL')

DATABASE_SERVER_NAME = os.getenv('DATABASE_SERVER_NAME')
DATABASE_NAME = os.getenv('DATABASE_NAME')
TABLE_NAME = os.getenv('TABLE_NAME')