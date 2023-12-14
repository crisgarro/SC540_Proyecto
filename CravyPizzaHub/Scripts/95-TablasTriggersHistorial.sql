-- Para log_creacion_usuario_table
CREATE TABLE log_creacion_usuario_table (
    usuario VARCHAR2(30),
    fecha_creacion DATE,
    usuario_creado VARCHAR2(30)
);

-- Para log_creacion_producto_table
CREATE TABLE log_creacion_producto_table (
    usuario VARCHAR2(30),
    fecha_creacion DATE,
    producto_creado VARCHAR2(255) -- Ajusta el tamaño según tus necesidades
);
