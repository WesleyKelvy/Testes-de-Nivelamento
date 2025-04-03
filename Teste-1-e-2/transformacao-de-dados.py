import pdfplumber
import pandas as pd
import zipfile

# Nome do PDF do Desafio 1
pdf_filename = "downloads/Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf"
csv_filename = "Rol_de_Procedimentos.csv"
zip_filename = "Teste_Wesley.zip"

# Dicionário de substituição para OD e AMB
substituicoes = {
    "OD": "Seg. Odontológica",
    "AMB": "Seg. Ambulatorial"
}

# Função para extrair tabelas do PDF
def extrair_tabela(pdf_path):
    data = []
    with pdfplumber.open(pdf_path) as pdf:
        for page in pdf.pages:
            tables = page.extract_table()
            if tables:
                for row in tables:
                    data.append(row)
    return data

# Extrai dados da tabela do PDF
dados_tabela = extrair_tabela(pdf_filename)

if not dados_tabela:
    print("Nenhuma tabela encontrada no PDF.")
    exit()

# Verifica se a primeira linha contém os cabeçalhos e remove
if "PROCEDIMENTO" in dados_tabela[0]:  
    dados_tabela.pop(0)

# Cria o DataFrame com dados extraidos
df = pd.DataFrame(dados_tabela)

# Define os cabeçalhos da tabela
df.columns = ["PROCEDIMENTO", "RN(alteração)", "VIGÊNCIA", "Seg. Odontológica", "Seg. Ambulatorial", "HCO", "REF", "PAC", "PAC", "DUT", "SUBGRUPO", "GRUPO", "CAPÍTULO"]

# Substitui os valores nas colunas desejadas
df["Seg. Odontológica"] = df["Seg. Odontológica"].map(substituicoes)
df["Seg. Ambulatorial"] = df["Seg. Ambulatorial"].map(substituicoes)

# Salva como CSV
df.to_csv(csv_filename, index=False, encoding="utf-8")

# Compactar o CSV em um ZIP
with zipfile.ZipFile(zip_filename, "w", zipfile.ZIP_DEFLATED) as zipf:
    zipf.write(csv_filename)

print(f"Arquivo CSV salvo e compactado em: {zip_filename}")
