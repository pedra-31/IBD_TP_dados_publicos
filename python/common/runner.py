from pathlib import Path
import csv

from common.db import get_connection


def _ensure_dir(path: Path):
    path.mkdir(parents=True, exist_ok=True)


def run_sql_file(sql_path: Path, output_csv_path: Path | None = None):
    sql_text = sql_path.read_text(encoding="utf-8")

    with get_connection() as conn:
        with conn.cursor() as cur:
            cur.execute(sql_text)

            if cur.description is None:
                conn.commit()
                affected_rows = cur.rowcount
                print(f"[OK] {sql_path.name}: comando executado (linhas afetadas: {affected_rows})")
                return {
                    "file": str(sql_path),
                    "type": "command",
                    "affected_rows": affected_rows,
                    "output": None,
                }

            rows = cur.fetchall()
            columns = [desc.name for desc in cur.description]

            output_file = None
            if output_csv_path is not None:
                _ensure_dir(output_csv_path.parent)
                with output_csv_path.open("w", newline="", encoding="utf-8") as f:
                    writer = csv.writer(f)
                    writer.writerow(columns)
                    writer.writerows(rows)
                output_file = str(output_csv_path)

            print(f"[OK] {sql_path.name}: consulta executada ({len(rows)} linhas)")
            return {
                "file": str(sql_path),
                "type": "select",
                "rows": len(rows),
                "output": output_file,
            }


def run_sql_directory(queries_dir: Path, output_dir: Path):
    _ensure_dir(output_dir)

    sql_files = sorted(queries_dir.glob("*.sql"))
    if not sql_files:
        print(f"[AVISO] Nenhum arquivo SQL encontrado em: {queries_dir}")
        return []

    results = []
    for sql_file in sql_files:
        output_csv = output_dir / f"{sql_file.stem}.csv"
        result = run_sql_file(sql_file, output_csv_path=output_csv)
        results.append(result)

    return results
