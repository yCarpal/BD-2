SELECT F.codigo AS codigo_funcionario, F.nome AS nome_funcionario, 
       M.codigo AS codigo_medico, M.nome AS nome_medico
FROM Funcionarios F
JOIN Medicos M ON F.cidade_residencia = M.cidade_residencia;
