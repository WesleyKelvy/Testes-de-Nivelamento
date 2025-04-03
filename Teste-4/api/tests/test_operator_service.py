import pytest
from ..service.operator_service import OperatorService
from ..repositories.operator_repository import OperatorRepository
from ..models.operator_model import Operator

@pytest.fixture
def mock_repository():
    class MockRepository(OperatorRepository):
        def __init__(self):
            pass

        def search_operators(self, termo: str):
            return [
                Operator(Registro_ANS=123, CNPJ="12345678901234", Razao_Social="Teste 1", Nome_Fantasia="Operadora 1"),
                Operator(Registro_ANS=456, CNPJ="56789012345678", Razao_Social="Teste 2", Nome_Fantasia="Operadora 2"),
            ] if termo == "Operadora" else []

    return MockRepository()

def test_search_operators_valid_term(mock_repository):
    service = OperatorService(mock_repository)
    result = service.search_operators("Operadora")
    assert len(result) == 2

def test_search_operators_invalid_term(mock_repository):
    service = OperatorService(mock_repository)
    with pytest.raises(ValueError):
        service.search_operators("op")

def test_search_operators_no_results(mock_repository):
    service = OperatorService(mock_repository)
    result = service.search_operators("Inexistente")
    assert len(result) == 0
