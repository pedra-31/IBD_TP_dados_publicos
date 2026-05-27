from argparse import ArgumentParser
from importlib import import_module

#definindo os stage
STAGES = {
    "1": "tasks.etapa_01_caracterizacao_inicial",
    "2": "tasks.etapa_02_definicao_objetivos",
    "3": "tasks.etapa_03_preparacao_dados",
    "4": "tasks.etapa_04_analise_descritiva",
    "5": "tasks.etapa_05_analise_orientada_objetivos",
    "6": "tasks.etapa_06_interpretacao_visualizacao",
}

#roda um stage
def run_stage(code: str):
    module = import_module(STAGES[code])
    module.run()

def main():
    #para cada stage, roda ele
    for stage in sorted(STAGES.keys()):
        print(f"\n=== Executando etapa {stage} ===")
        run_stage(stage)
    return


if __name__ == "__main__":
    main()
