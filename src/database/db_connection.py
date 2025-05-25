from sqlalchemy import create_engine
from sqlalchemy.sql import text

class Database:
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(Database, cls).__new__(cls)
            # PostgreSQL connection string
            cls._instance.engine = create_engine(
                'postgresql+psycopg2://postgres:admin%40123@localhost:5432/ecommerce'
            )
            cls._instance.conn = cls._instance.engine.connect()
        return cls._instance

    def execute_query(self, query, params=None):
        with self.conn.begin():
            result = self.conn.execute(text(query), params or {})
            if result.returns_rows:
                return result.fetchall()
            return []

    def close(self):
        self.conn.close()
        self.engine.dispose()