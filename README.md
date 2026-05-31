# IBD TP - Fluxo de Trabalho

Este repositório segue a ideia de manter os dados originais intactos e criar camadas de preparo/análise por SQL.

## Estrutura

- `csv/`: arquivos brutos e exportações em CSV.
- `sql/`: scripts SQL (carga, views, consultas de análise).
- `python/`: scripts auxiliares (quando necessário).
- `etc/`: documentação de apoio, incluindo o enunciado.

## Regras

- Não alterar manualmente os dados brutos no banco.
- Carregar o bruto em tabelas `raw_*`.
- Fazer limpeza, padronização e integração em `views` (ou tabelas derivadas quando realmente necessário).

## Fluxo recomendado

1. Com o docker desktop rodando, subir o ambiente Docker

```bash
docker compose up
```

2. Executar as consultas do trabalho em python

- Caracterização inicial.
- Preparação dos dados.
- Análise descritiva.
- Análise orientada às perguntas de pesquisa.

3. Exportar resultados para CSV

- Exportar resultados (principalmente views de análise) para a pasta de saída: `csv/exports/`.
- Usar esses arquivos para relatório, gráficos e publicação.

4. Versionar tudo

- Versionar scripts SQL, consultas, documentação da fonte e decisões de modelagem.
- Registrar limitações e qualidade dos dados para a análise crítica da Parte 2.
