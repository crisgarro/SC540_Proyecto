-- Creacion de Tablespace CravyPizzaHub
CREATE TABLESPACE CravyPizzaHub
DATAFILE 'C:\git\Bases\CrazyPizzaHub.dbf' SIZE 500M
AUTOEXTEND ON NEXT 1M MAXSIZE UNLIMITED
DEFAULT STORAGE (INITIAL 1M NEXT 1M PCTINCREASE 0);

-- Creacion de Usuario CravyDev para funciones de desarollo
CREATE USER CravyDev IDENTIFIED BY abcd1234
DEFAULT TABLESPACE CravyPizzaHub
QUOTA UNLIMITED ON CravyPizzaHub;

-- Asignacion de Privilegios de Admin para CrazzyDev
GRANT DBA TO CravyDev;
