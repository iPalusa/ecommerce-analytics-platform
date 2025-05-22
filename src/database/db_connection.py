import sqlite3

class Database:
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(Database, cls).__new__(cls)
            cls._instance.conn = sqlite3.connect('../data/database/ecommerce.db')
            cls._instance.conn.row_factory = sqlite3.Row  # Enable row access by column name
            cls._instance.cursor = cls._instance.conn.cursor()
        return cls._instance

    def execute_query(self, query, params=()):
        self.cursor.execute(query, params)
        self.conn.commit()
        return self.cursor.fetchall()

    def close(self):
        self.conn.close()