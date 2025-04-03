from fastapi import APIRouter, Query, HTTPException
from service.operator_service import OperatorService
from repositories.operator_repository import OperatorRepository
from models.operator_model import Operator
from typing import List
from pydantic import BaseModel

router = APIRouter()

class SearchResponse(BaseModel):
    total_resultados: int
    operadoras: List[Operator]

repository = OperatorRepository("data/Relatorio_cadop.csv")
service = OperatorService(repository)

@router.get("/buscar-operadoras/", response_model=SearchResponse)
def search_operators(search: str = Query(...)): 
    try:
        operators = service.search_operators(search)
        return {"total_resultados": len(operators), "operadoras": operators}
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    