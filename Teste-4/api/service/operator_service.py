from repositories.operator_repository import OperatorRepository
from models.operator_model import Operator
from typing import List
from fastapi import HTTPException


class OperatorService:
    def __init__(self, repository: OperatorRepository):
        self.repository = repository

    def search_operators(self, search: str) -> List[Operator]:
        if len(search) < 3:
            raise HTTPException(
                status_code=400, detail="O termo de busca deve ter pelo menos 3 caracteres.")
        return self.repository.search_operators(search)
