SELECT F.nome, F.salario
FROM Funcionarios F
JOIN Funcionarios C ON F.cidade_residencia = C.cidade_residencia
WHERE C.nome = 'Carlos' AND F.salario > C.salario;