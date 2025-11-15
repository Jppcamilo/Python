# Projeto LevelUp (FIAP)

Este projeto implementa um sistema de aprendizado gamificado de Soft Skills, utilizando Python e um banco de dados Oracle.

## 1. Pré-requisitos

Para executar este projeto, você precisará de:
* Python 3.x
* Acesso a um banco de dados Oracle (SQL Developer, etc.)
* A biblioteca Python `oracledb`

## 2. Configuração do Banco de Dados

1.  **Criar as Tabelas:** Abra o arquivo `create_table.sql` no seu cliente Oracle (ex: SQL Developer) e execute o script inteiro. Isso criará todas as tabelas, sequências, triggers e inserirá os dados iniciais (planos e usuário admin).
2.  **Confirmar (Commit):** Após executar o script, rode o comando `COMMIT;` para salvar as mudanças permanentemente.

## 3. Configuração do Python

1.  **Instalar a Biblioteca:** Abra seu terminal ou prompt de comando e instale a biblioteca `oracledb`:
    ```bash
    pip install oracledb
    ```

2.  **Credenciais de Acesso:** Crie um arquivo chamado `secret.txt` na **mesma pasta** do seu arquivo Python (`.ipynb` ou `.py`). O conteúdo deve ser um JSON com suas credenciais do Oracle:

    ```json
    {
        "user": "SEU_USUARIO_RM",
        "password": "SUA_SENHA",
        "dsn": "oracle.fiap.com.br/orcl"
    }
    ```
    *Substitua pelos seus dados.*

## 4. Execução

1.  Abra o notebook `Python.ipynb` (ex: no VS Code ou Jupyter Notebook).
2.  Execute todas as células na ordem.
3.  O menu principal do sistema aparecerá no final.

### Credenciais de Teste

* **Login Admin:**
    * **Email:** `admin@skillup.com`
    * **Senha:** `admin123`
* **Usuário Comum:**
    * Você pode criar um novo usuário na opção "1 - Registrar".