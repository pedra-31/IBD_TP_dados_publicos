from pathlib import Path

from common.runner import run_sql_directory


BASE_DIR = Path(__file__).resolve().parents[1]
QUERIES_DIR = BASE_DIR / "queries" / "06_visualizacao"
OUTPUT_DIR = BASE_DIR / "outputs" / "06_visualizacao"
RESUMO_FILE = OUTPUT_DIR / "resumo_resultados.md"


RESUMO_TEMPLATE = """
"""



#lembrando que esse run é chamado no main
def run():
    #roda as chamadas sql
    results = run_sql_directory(QUERIES_DIR, OUTPUT_DIR)
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    if not RESUMO_FILE.exists():
        RESUMO_FILE.write_text(RESUMO_TEMPLATE, encoding="utf-8")
        print(f"[OK] Template criado: {RESUMO_FILE}")
    else:
        print(f"[OK] Template ja existe: {RESUMO_FILE}")

    return results

