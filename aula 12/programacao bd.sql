---VIEWS---
---STORED PROCEDUVES---
---FUNCTIONS---
---TRIGGERS---


estensao .sql

---apenas um arquivo 

ex---

---CREATE VIEW v_pedidosClientes AS 
    SELECT *
        FROM clientes c 
        JOIN pedidos ON p.idcliente = c.idcliente---