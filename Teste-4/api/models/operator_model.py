from pydantic import BaseModel

class Operator(BaseModel):
    Registro_ANS: int
    CNPJ: int
    Razao_Social: str
    Nome_Fantasia: str
