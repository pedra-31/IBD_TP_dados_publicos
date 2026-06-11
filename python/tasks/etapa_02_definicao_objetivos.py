from pathlib import Path


BASE_DIR = Path(__file__).resolve().parents[1]
OUTPUT_DIR = BASE_DIR / "outputs" / "02_definicao_objetivos"
OUTPUT_FILE = OUTPUT_DIR / "questoes_de_pesquisa.md"


TEMPLATE = """
# Etapa 2 - Definicao dos objetivos

Esta etapa é conceitual. Não á necessidade de fazer chamadas sql
"""


#lembrando que esse run é chamado no main
def run():
    #roda as chamadas sql
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    if not OUTPUT_FILE.exists():
        OUTPUT_FILE.write_text(TEMPLATE, encoding="utf-8")
        print(f"[OK] Template criado: {OUTPUT_FILE}")
    else:
        print(f"[OK] Template ja existe: {OUTPUT_FILE}")

    return [{"file": str(OUTPUT_FILE), "type": "template"}]

