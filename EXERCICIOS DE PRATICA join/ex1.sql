---1) Buscar o número e o andar dos ambulatórios utilizados por médicos ortopedistas---


SELECT A.numero, A.andar
FROM Ambulatorios A
JOIN Medicos M on A.codigo_medico = M.codigo
WHERE M.especialidade = 'Ortopedista';


