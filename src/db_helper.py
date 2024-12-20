from sqlalchemy import text
from config import db, app

table_name = "citations" # pylint: disable=invalid-name


def table_exists(name):
    sql_table_existence = text(
        "SELECT EXISTS ("
        "  SELECT 1"
        "  FROM information_schema.tables"
        f" WHERE table_name = '{name}'"
        ")"
    )

    print(f"Checking if table {name} exists")
    print(sql_table_existence)

    result = db.session.execute(sql_table_existence)
    return result.fetchall()[0][0]


def reset_db():
    print(f"Clearing contents from table {table_name}")
    sql = text(f"DELETE FROM {table_name}")
    db.session.execute(sql)
    db.session.commit()


def setup_db():
    if table_exists(table_name):
        print(f"Table {table_name} exists, dropping")
        sql = text(f"DROP TABLE {table_name}")
        db.session.execute(sql)
        db.session.commit()

    print(f"Creating table {table_name}")
    sql = text(
        f"CREATE TABLE {table_name} ("
        "  id SERIAL PRIMARY KEY, "
        "  type TEXT NOT NULL,"
        "  author TEXT NOT NULL,"
        "  title TEXT NOT NULL,"
        "  year INT NOT NULL,"
        "  booktitle TEXT,"
        "  journal TEXT,"
        "  volume TEXT,"
        "  pages TEXT,"
        "  publisher TEXT"
        ")"
    )

    db.session.execute(sql)
    db.session.commit()


if __name__ == "__main__":
    with app.app_context():
        setup_db()
