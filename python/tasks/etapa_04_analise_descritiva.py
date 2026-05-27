from pathlib import Path

from common.runner import run_sql_directory


BASE_DIR = Path(__file__).resolve().parents[1]
QUERIES_DIR = BASE_DIR / "queries" / "04_analise_descritiva"
OUTPUT_DIR = BASE_DIR / "outputs" / "04_analise_descritiva"


#lembrando que esse run é chamado no main
def run():
    #roda as chamadas sql
    return run_sql_directory(QUERIES_DIR, OUTPUT_DIR)

