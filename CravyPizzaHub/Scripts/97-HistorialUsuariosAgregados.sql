CREATE OR REPLACE TRIGGER log_creacion_usuario
BEFORE INSERT ON users
FOR EACH ROW
DECLARE
    usuario_actual VARCHAR2(30);
BEGIN
    -- Obtener el nombre del usuario actual
    usuario_actual := SYS_CONTEXT('USERENV', 'SESSION_USER');
    
    -- Registrar la información en una tabla de log (ajusta la tabla según tus necesidades)
    INSERT INTO log_creacion_usuario_table (usuario, fecha_creacion, usuario_creado)
    VALUES (usuario_actual, SYSDATE, :NEW.USERNAME);
END;
/
