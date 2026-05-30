import os

import psycopg

def get_connection():
    return psycopg.connect(
        dbname=os.getenv("DB_NAME", "analytics"),
        user=os.getenv("DB_USER", "user"),
        password=os.getenv("DB_PASSWORD", "password"),
        host=os.getenv("DB_HOST", "db"),
        port=os.getenv("DB_PORT", "5432"),
    )
