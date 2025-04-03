import os
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin
import zipfile

# Pastas para salvar os arquivos temporariamente
download_dir = "downloads"
zip_filename = "anexos.zip"

os.makedirs(download_dir, exist_ok=True)

# pasando a URL da página da ANS
url = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"

# Fazer a requisição para a ANS
response = requests.get(url)
response.raise_for_status()  # Mostra erro se a requisição falhar

# Analisa o HTML 
soup = BeautifulSoup(response.text, "html.parser")

# Encontrar links para os anexos em PDF
print("Procurando os PDFs!")
pdf_links = []
for link in soup.find_all("a", href=True):
    href = link["href"]
    if "Anexo" in href and href.endswith(".pdf"):
        pdf_links.append(urljoin(url, href))


# Baixa e salva os PDFs
print("Iniciando o download dos PDFs!")
pdf_files = []
for pdf_url in pdf_links:
    # Cria o caminho completo onde o arquivo será salvo, o pdf_url.split é usado dividir a URL pelas barras e pegar o último elemento, o nome do documento
    pdf_name = os.path.join(download_dir, pdf_url.split("/")[-1])
    pdf_files.append(pdf_name)

    # O bloco with garante que a conexão seja fechada adequadamente após o uso
    with requests.get(pdf_url, stream=True) as req: # stream=True permite baixar o arquivo em partes (chunks)
        req.raise_for_status() # Verifica se houve algum erro durante a requisição HTTP
        with open(pdf_name, "wb") as file: # Abre um arquivo local para escrita em modo binário
            for chunk in req.iter_content(chunk_size=8192): # Recebe o arquivo em pedaços de 8192 bytes (8KB) para não sobrecarregar a memória.
                file.write(chunk) # Escreve cada pedaço (chunk) no arquivo local.
    print(f"Baixado: {pdf_name}")

# Compactar os arquivos em um ZIP
print("Iniciando a compactação dos PDFs!")
zip_path = os.path.join(download_dir, zip_filename) # Cria o caminho completo onde o arquivo será salvo
 
# "zipfile.ZipFile" Abre um arquivo ZIP para escrita:
# 1 - zip_path é o local onde o ZIP será criado
# 2 - O "w" significa criar um novo arquivo
# 3 - "zipfile.ZIP_DEFLATED" especifica o método de compressão
with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as zipf:  
    for pdf in pdf_files:
        zipf.write(pdf, os.path.basename(pdf)) # Adiciona cada arquivo PDF ao ZIP

print(f"Arquivos compactados em: {zip_path}")