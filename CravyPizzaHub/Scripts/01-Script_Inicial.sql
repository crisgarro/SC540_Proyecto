-- Eliminar el Tablespace si existe
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
DATAFILE '/opt/oracle/oradata/ORCLCDB/CravyPizzaHub.dbf' SIZE 50M
AUTOEXTEND ON NEXT 1M MAXSIZE UNLIMITED
DEFAULT STORAGE (INITIAL 1M NEXT 1M PCTINCREASE 0);

-- Creacion de Usuario CravyDev para funciones de desarollo
CREATE USER CravyDev IDENTIFIED BY abcd1234
DEFAULT TABLESPACE CravyPizzaHub
QUOTA UNLIMITED ON CravyPizzaHub;

-- Asignacion de Privilegios de Admin para CravyDev
GRANT DBA TO CravyDev;

/*
Correr esto para verificar el path de los tablespaces
Si el archivo existe actualizar el "Eliminar el Tablespace si existe" 
y agregar el nombre del tablesspace al delete, se ejecuta solo esa seccion
una vez que se elimino el tablespace, entonces pueden correr todo el script

SELECT file_name, tablespace_name
FROM dba_data_files
WHERE file_name = '/CravyPizzaHub.dbf';*/