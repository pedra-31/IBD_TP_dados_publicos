# IBD TP - Fluxo de Trabalho

Este repositório segue a ideia de manter os dados originais intactos e criar camadas de preparo/análise por SQL.

## Estrutura

- `csv/`: arquivos brutos e exportações em CSV.
- `init/`: arquivos de inicialização do banco de dados
- `python/`: runner e scripts sql.

## Fluxo 

Com o docker desktop rodando, subir o ambiente Docker

```bash
docker compose down -v
docker compose up --build
```

Isso inicia o banco de dados, roda os scripts sql e gera os outputs em: `python\outputs`
