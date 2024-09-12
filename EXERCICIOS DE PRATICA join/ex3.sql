SELECT M.codigo, M.nome
FROM Medicos M
JOIN Consultas C ON M.codigo = C.codigo_medico
WHERE C.horario < '12:00:00'
  AND M.idade < (
      SELECT idade
      FROM Medicos
      WHERE nome = 'Maria'
  );