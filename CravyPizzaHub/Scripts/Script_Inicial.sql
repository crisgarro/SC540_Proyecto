-- Drop tablespace if it exists
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLESPACE CravyPizzaHub INCLUDING CONTENTS AND DATAFILES';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
      --RAISE;
      DBMS_OUTPUT.PUT_LINE('Error Recreando Tablespace.');
    END IF;
END;
/

-- Drop user if it exists
BEGIN
  EXECUTE IMMEDIATE 'DROP USER CravyDev CASCADE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -1918 THEN
      --RAISE;
      DBMS_OUTPUT.PUT_LINE('Error Recreando Usuarios.');
    END IF;
END;
/

-- Creacion de Tablespace CravyPizzaHub
CREATE TABLESPACE CravyPizzaHub
DATAFILE '/opt/oracle/oradata/ORCLCDB/CrazyPizzaHub.dbf' SIZE 50M
AUTOEXTEND ON NEXT 1M MAXSIZE UNLIMITED
DEFAULT STORAGE (INITIAL 1M NEXT 1M PCTINCREASE 0);

-- Creacion de Usuario CravyDev para funciones de desarollo
CREATE USER CravyDev IDENTIFIED BY abcd1234
DEFAULT TABLESPACE CravyPizzaHub
QUOTA UNLIMITED ON CravyPizzaHub;

-- Asignacion de Privilegios de Admin para CrazzyDev
GRANT DBA TO CravyDev;

