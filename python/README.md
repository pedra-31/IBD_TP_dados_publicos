# Estrutura sugerida da Parte 2

Esta pasta foi organizada de acordo com separacao por etapa do enunciado.

## Pastas e responsabilidades

- `common/db.py`: conexao com PostgreSQL via variaveis de ambiente.
- `common/runner.py`: executor de SQL (roda `.sql` e salva CSV em `outputs/`).
- `tasks/`: um arquivo Python por etapa da Parte 2.
- `queries/`: consultas SQL por etapa.
- `outputs/`: resultados gerados (CSV e templates para relatorio).
- `main.py`: ponto unico para executar uma etapa ou todas.

## O que vai em cada etapa

- Etapa 1 (`queries/01_caracterizacao_inicial`):
  - 5 consultas SQL para mapear tabelas, colunas, volume e dimensoes.
- Etapa 2 (`tasks/etapa_02_definicao_objetivos.py`):
  - Gera `outputs/02_definicao_objetivos/questoes_de_pesquisa.md` (minimo 2 perguntas).
- Etapa 3 (`queries/03_preparacao_dados`):
  - 5 consultas SQL de limpeza/preparo (duplicados, nulos, padronizacao, derivados).
- Etapa 4 (`queries/04_analise_descritiva`):
  - 5 consultas SQL de estatisticas e distribuicoes.
- Etapa 5 (`queries/05_analise_orientada_objetivos`):
  - 5 consultas SQL alinhadas as perguntas de pesquisa.
- Etapa 6 (`queries/06_visualizacao`):
  - Consultas para extrair tabelas de graficos e sintese final.
  - Gera `outputs/06_visualizacao/resumo_resultados.md`.

## Como executar

No container/ambiente Python:

```bash
python main.py
```

## Regras para evitar dor de cabeca

- Cada pessoa edita somente:
  - sua pasta de `queries/XX_*`
  - seu arquivo `tasks/etapa_XX_*.py` (se precisar)
  - sua secao do relatorio
- Nomes padrao de arquivos SQL:
  - `q01_*`, `q02_*`, ... para manter ordem e rastreabilidade
- Cada consulta deve ser reproduzivel:
  - sem edicao manual de CSV
  - resultado sempre sai de SQL

