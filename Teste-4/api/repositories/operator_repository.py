import pandas as pd
from typing import List
from models.operator_model import Operator


class OperatorRepository:
    def __init__(self, csv_path: str):
        self.df = pd.read_csv(csv_path, delimiter=";", encoding="utf-8")
        self.df.columns = self.df.columns.str.strip()

    def search_operators(self, termo: str) -> List[Operator]:
        filtro = self.df[
            self.df["Nome_Fantasia"].str.contains(termo, case=False, na=False) |
            self.df["Razao_Social"].str.contains(termo, case=False, na=False)
        ]

        result = filtro[["Registro_ANS", "CNPJ",
                         "Razao_Social", "Nome_Fantasia"]].fillna("")
        return [Operator(**row) for row in result.to_dict(orient="records")]
