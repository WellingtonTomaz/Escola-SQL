--CONSULTA 1 - Retornar informações dos alunos ordenados pelo nome

SELECT*FROM TabelaAlunos 
ORDER BY nome_do_aluno;


--CONSULTA 2 - Retornar disciplina com carga horaria maior do que 40

SELECT*from TabelaDisciplinas
WHERE carga_horaria > '40';


--CONSULTA 3 Buscar notas que são maiores que 6 e menores que 8

SELECT*FROM Tabela_Notas
WHERE valor_nota BETWEEN 6 AND 8


--CONSULTA 4 Retornar a média de Notas dos Alunos em história

SELECT AVG (valor_nota)
FROM Tabela_Notas
WHERE id_disciplina = (SELECT id_disciplina from TabelaDisciplinas
                       WHERE nome_da_disciplina = 'História');
                       

--CONSULTA 5 Retornar informações dos alunos cujo Nome começa com 'A'

SELECT*FROM TabelaAlunos
WHERE nome_do_aluno like 'A%';


--CONSULTA 6 Consulta que calcula a idade dos alunos

SELECT 
    nome_do_aluno,
    strftime('%Y', 'now') - strftime('%Y', data_de_nascimento) AS Idade
FROM 
    TabelaAlunos;


--CONSULTA 7 Realizar classificação das notas dos alunos

SELECT id_aluno,valor_nota,
   CASE
     WHEN ROUND (valor_nota) BETWEEN 1 AND 3 THEN 'Ruim'
     WHEN ROUND (valor_nota) BETWEEN 4 AND 7 THEN 'Media'
     ELSE 'Alto'
END AS Classificação
              FROM Tabela_Notas
              
              
--CONSULTA 8 Retornar se o aluno está ou não aprovado             
                       
 SELECT 
    id_aluno,
    valor_nota,
    id_disciplina,
    CASE 
        WHEN valor_nota > 6 THEN 'Aprovado'
        ELSE 'Reprovado'
    END AS situacao
FROM 
    Tabela_Notas;                      

--CONSULTA 9 Retornar o aluno com a maior nota entre todas as disciplinas

SELECT*FROM Tabela_Notas
WHERE valor_nota = (select MAX(valor_nota) FROM Tabela_Notas)

--CONSULTA 10 Buscando o nome do profedssor e a turma que ele é orientador

SELECT p.nome_do_professor, t.nome_da_turma
FROM TabelaProfessores p
JOIN TabelaTurmas t ON p.Id_Professor = t.Id_Professor_orientador

--CONSULTA 11 Aluno com maior nota na disciplina matematica 

SELECT a.nome_do_aluno, MAX(valor_nota) AS maior_nota
FROM TabelaAlunos a 
JOIN Tabela_Notas n on a.Id_Aluno = n.Id_Aluno
JOIN TabelaDisciplinas d ON d.Id_Disciplina = n.Id_Disciplina
WHERE n.Id_Disciplina = 1;

-- CONSULTA 12 Total de alunos por turma

SELECT t.nome_da_turma, count(ta.id_turma) AS total_alunos_turma
FROM TabelaTurmas t
JOIN Tabela_Turma_Alunos ta on t.Id_Turma = ta.Id_Turma
GROUP BY nome_da_turma

-- CONSULTA 13 Listar alunos as disciplinas que estão matriculados

SELECT a.nome_do_aluno , d.nome_da_disciplina
FROM TabelaAlunos a
JOIN Tabela_Turma_Alunos ta ON a.Id_Aluno = ta.Id_Aluno
JOIN Tabela_Turmas_Disciplinas td ON ta.Id_Turma = td.Id_Turma
JOIN TabelaDisciplinas d ON d.Id_Disciplina = td.Id_Disciplina

--CONSULTA 14 Alunos aprovados em matematica

SELECT nome_do_aluno, valor_nota
from tabelaAlunos a
JOIN Tabela_Notas n on n.id_aluno = a.id_aluno
WHERE n.Id_Disciplina = 1 and valor_nota >= 7

--CONSULTA 15 Total de disciplinas por turma 

SELECT t.Nome_da_turma , COUNT(td.Id_Disciplina) as Total_Disciplinas
FROM Tabela_Turmas_Disciplinas td
JOIN TabelaTurmas t ON t.Id_Turma = td.Id_Turma
GROUP by id_disciplina

--CONSULTA 16 Porcentagem dos alunos que estão aprovados
  
SELECT
    (SELECT COUNT(*) FROM TabelaAlunos) AS Total_Alunos,
    (SELECT COUNT(*) FROM TabelaAlunos a JOIN Tabela_Notas n ON n.ID_Aluno = a.ID_Aluno WHERE n.Valor_Nota >= 7.0) AS Alunos_Aprovados,
    (SELECT COUNT(*) FROM Tabela_Notas) AS Total_Notas,
    (ROUND(100.0 * (SELECT COUNT(*) FROM TabelaAlunos a JOIN Tabela_Notas n ON n.ID_Aluno = a.ID_Aluno WHERE n.Valor_Nota >= 7.0) / (SELECT COUNT(*) 
    FROM Tabela_Notas), 2) || '%') AS Porcentagem     