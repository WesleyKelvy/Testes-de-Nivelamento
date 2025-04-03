## Tecnologias Utilizadas

* **PostgreSQL 17.2:**
    * Utilizado como sistema de gerenciamento de banco de dados para armazenar e consultar os dados.
* **DBeaver 25.0.0:**
    * Ferramenta de banco de dados utilizada para desenvolver e executar os scripts SQL.
* **Docker:**
    * Utilizado para isolar o ambiente do banco de dados postgres, e para o transporte dos arquivos csv para dentro do container do postgres.
* **SQL (Structured Query Language):**
    * Linguagem de consulta estruturada usada para criar tabelas, importar dados e realizar análises.
* **CSV (Comma-Separated Values):**
    * Formato de arquivo utilizado para importar os dados das operadoras e demonstrações contábeis.

## Estrutura do Projeto

O projeto é organizado da seguinte forma:

* **Scripts SQL:**
    * `estruturacao_tabelas.sql`: Contém os scripts para criar as tabelas `operadoras` e `demonstracoes_contabeis`.
    * `importacao_dados.sql`: Contém os scripts para importar os dados dos arquivos CSV para as tabelas criadas.
    * `queries_analiticas.sql`: Contém as queries analíticas para responder às perguntas do desafio.
* **Dados:**
    * Os arquivos CSV de dados das operadoras e demonstrações contábeis devem ser baixados dos links fornecidos.

## Instruções de Execução

1.  **Configuração do Banco de Dados:**
    * Certifique-se de ter o docker instalado e configurado.
    * Crie um container do docker com o PostgreSQL, usando docker compose por exemplo.
    * Utilize os comandos docker cp para enviar os arquivos .csv para dentro do container postgres.
2.  **Execução dos Scripts SQL:**
    * Abra o DBeaver ou outra ferramenta de banco de dados compatível com PostgreSQL.
    * Execute os scripts SQL na seguinte ordem:
        1.  `estruturacao_tabelas.sql`
        2.  `importacao_dados.sql`
        3.  `queries_analiticas.sql`
3.  **Resultados:**
    * Os resultados das queries analíticas serão exibidos na ferramenta de banco de dados.


## Observações

* Os scripts SQL foram desenvolvidos e testados no PostgreSQL 17.2 e DBeaver 25.0.0.
* Os arquivos CSV de dados devem estar no local especificado nos scripts de importação. (Modificar diretórios conforme necessário)