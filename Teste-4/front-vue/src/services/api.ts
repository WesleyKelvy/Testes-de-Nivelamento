import axios from 'axios'

const API_BASE_URL = 'http://127.0.0.1:8000'

export interface Operator {
  Registro_ANS: string
  CNPJ: string
  Razao_Social: string
  Nome_Fantasia: string
  Modalidade: string
  UF: string
}

interface SearchResponse {
  total_resultados: number
  operadoras: Operator[]
}

export const searchOperators = async (search: string): Promise<SearchResponse> => {
  try {
    const response = await axios.get<SearchResponse>(`${API_BASE_URL}/buscar-operadoras/`, {
      params: { search },
    })
    // console.log('response: ', response)

    return response.data
  } catch (error: any) {
    console.error('API error:', error.response?.data) // Detailed error logging

    return {
      total_resultados: 0,
      operadoras: [],
    }
  }
}
