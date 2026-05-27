from pathlib import Path

from common.runner import run_sql_directory


BASE_DIR = Path(__file__).resolve().parents[1]
QUERIES_DIR = BASE_DIR / "queries" / "01_caracterizacao_inicial"
OUTPUT_DIR = BASE_DIR / "outputs" / "01_caracterizacao_inicial"

#lembrando que esse run é chamado no main
def run():
    #roda as chamadas sql
    return run_sql_directory(QUERIES_DIR, OUTPUT_DIR)

