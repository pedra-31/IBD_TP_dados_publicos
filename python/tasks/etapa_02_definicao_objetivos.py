from pathlib import Path


BASE_DIR = Path(__file__).resolve().parents[1]
OUTPUT_DIR = BASE_DIR / "outputs" / "02_definicao_objetivos"
OUTPUT_FILE = OUTPUT_DIR / "questoes_de_pesquisa.md"


TEMPLATE = """# Questoes de pesquisa

## Questao 1
- Pergunta:
- Motivacao:
- Tabelas e atributos:
- Filtro temporal/geografico:

## Questao 2
- Pergunta:
- Motivacao:
- Tabelas e atributos:
- Filtro temporal/geografico:

## Hipoteses iniciais
- Hipotese 1:
- Hipotese 2:
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

