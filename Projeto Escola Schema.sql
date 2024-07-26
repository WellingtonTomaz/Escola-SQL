CREATE TABLE TabelaAlunos (
    Id_Aluno INT PRIMARY KEY, 
    Nome_do_aluno VARCHAR(150), 
    Data_de_nascimento DATE, 
    Genero VARCHAR(15), 
    Endereco VARCHAR(50), 
    Telefone_aluno VARCHAR(20), 
    Endereco_de_Email VARCHAR(100)
);

CREATE TABLE TabelaProfessores (
    Id_Professor INT PRIMARY KEY, 
    Nome_do_Professor VARCHAR(150),  
    Data_de_nascimento DATE, 
    Genero VARCHAR(15), 
    Telefone_Professor VARCHAR(20), 
    Endereco_de_Email VARCHAR(100)
);

CREATE TABLE TabelaDisciplinas (
    Id_Disciplina INT PRIMARY KEY, 
    Nome_da_disciplina VARCHAR(100), 
    Descricao VARCHAR(150), 
    Carga_Horaria INT,
    Id_Professor INT,
    FOREIGN KEY (Id_Professor) REFERENCES TabelaProfessores(Id_Professor)
);

CREATE TABLE TabelaTurmas (
    Id_Turma INT PRIMARY KEY, 
    Nome_da_turma VARCHAR(50), 
    Ano_letivo DATE, 
    Id_Professor_orientador INT,
    FOREIGN KEY (Id_Professor_orientador) REFERENCES TabelaProfessores(Id_Professor)
);

CREATE TABLE Tabela_Turmas_Disciplinas (
    Id_Turma INT, 
    Id_Disciplina INT,
    PRIMARY KEY(Id_Turma, Id_Disciplina),
    FOREIGN KEY(Id_Turma) REFERENCES TabelaTurmas(Id_Turma),
    FOREIGN KEY(Id_Disciplina) REFERENCES TabelaDisciplinas(Id_Disciplina)
);

CREATE TABLE Tabela_Turma_Alunos (
    Id_Turma INT, 
    Id_Aluno INT,
    PRIMARY KEY(Id_Turma, Id_Aluno),
    FOREIGN KEY(Id_Turma) REFERENCES TabelaTurmas(Id_Turma),
    FOREIGN KEY(Id_Aluno) REFERENCES TabelaAlunos(Id_Aluno)
);

CREATE TABLE Tabela_Notas (
    Id_Nota INT PRIMARY KEY, 
    Id_Aluno INT, 
    Id_Disciplina INT, 
    Valor_Nota DECIMAL(10,2), 
    Data_Avaliacao DATE,
    FOREIGN KEY(Id_Aluno) REFERENCES TabelaAlunos(Id_Aluno), 
    FOREIGN KEY(Id_Disciplina) REFERENCES TabelaDisciplinas(Id_Disciplina)
);
                     
                           

                          