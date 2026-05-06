CREATE TABLE leituras (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sensor VARCHAR2(50) NOT NULL,
    valor FLOAT NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE alertas (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tipo VARCHAR2(100) NOT NULL,
    mensagem VARCHAR2(500) NOT NULL,
    valor FLOAT,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT table_name 
FROM user_tables 
WHERE table_name IN ('LEITURAS', 'ALERTAS');

INSERT INTO leituras (sensor, valor)
VALUES ('temperatura', 26.7);

COMMIT;

SELECT * FROM leituras;

INSERT INTO alertas (tipo, mensagem, valor)
VALUES ('Alerta de calor', 'Temperatura acima do limite', 40);

COMMIT;

SELECT * FROM alertas;