CREATE DATABASE IF NOT EXISTS hogarVital;

USE hogarVital;

CREATE TABLE categoria(id_categoria int(11) primary key,
nombre_categoria varchar(30) not null);

-- ----------------------------------------------------------- --

CREATE TABLE cargo(id_cargo int(11) primary key,
nombre_cargo varchar(40) not null);

-- ----------------------------------------------------------- --

create table lote_medicamento(id_loteM int(11) primary key auto_increment,
nombre_loteM varchar(50));

-- ----------------------------------------------------------- --

create table lote_alimento(id_loteA int(11) primary key auto_increment,
nombre_loteA varchar(50));

-- ----------------------------------------------------------- --

create table marca(id_marca int(11)primary key auto_increment,
nombre_marca varchar(40) not null);

-- ----------------------------------------------------------- --

CREATE TABLE usuarios(id_usuario int(11) primary key,
tipo_documento varchar(10) not null,
nombre_usuario varchar(30) not null,
apellido_usuario varchar(30) not null,
correo varchar(40) not null,
contrasena varchar(30) not null,
telefono varchar(15) not null,
direccion varchar(30) not null,
cargo_id int(11) not null,
fecha_registro_usuario datetime not null,
fecha_actualizacion_usuario datetime not null,
FOREIGN KEY (cargo_id) references cargo(id_cargo));

-- ----------------------------------------------------------- --

CREATE TABLE productos(id_producto int(11) primary key,
nombre_producto varchar(30) not null,
cantidad_producto int(11) not null,
fecha_registro_producto datetime not null,
fecha_actualizacion_producto datetime not null,
categoria_id int(11) not null,
marca_id int(11) not null,
FOREIGN KEY (categoria_id) REFERENCES categoria (id_categoria),
FOREIGN KEY (marca_id) REFERENCES marca (id_marca));

-- ----------------------------------------------------------- --

create table proveedores(id_proveedor int(11)primary key auto_increment,
nombre_proveedor varchar(40) not null);

-- ----------------------------------------------------------- --

create table medicamento(id_producto_medicamento int(11) primary key,
fecha_vencimientoM date not null,
loteM_id int(11) not null,
FOREIGN KEY (loteM_id) REFERENCES lote_medicamento(id_loteM),
FOREIGN KEY (id_producto_medicamento) REFERENCES productos(id_producto));

-- ----------------------------------------------------------- --

create table alimento(id_producto_alimento int(11) primary key,
fecha_vencimientoA date not null,
loteA_id int(11) not null,
FOREIGN KEY (loteA_id) REFERENCES lote_alimento(id_loteA),
FOREIGN KEY (id_producto_alimento) REFERENCES productos(id_producto));

-- ----------------------------------------------------------- --

create table usuarios_productos(usuario_id int(11) not null,
producto_id int(11) not null,
foreign key (usuario_id) references usuarios (id_usuario),
foreign key (producto_id) references productos (id_producto));

-- ----------------------------------------------------------- --

create table proveedores_productos(proveedor_id int(11) not null,
producto_id int(11) not null,
fecha_proveedor datetime not null,
foreign key (proveedor_id) references proveedores (id_proveedor),
foreign key (producto_id) references productos (id_producto));

/*Creacion procedimientos almacenados (Insertar/Insert) y (Mostrar/Select)*/

drop procedure InsertarCategoria
DELIMITER ##
create procedure InsertarCategoria(
c_categoria_id int(11),
c_nombre_categoria varchar(40))
begin
insert into categoria(id_categoria, nombre_categoria)
values(c_categoria_id, c_nombre_categoria);
end ##
DELIMITER ##;

call InsertarCategoria("1","Enseres");
call InsertarCategoria("2","Medicamento");
call InsertarCategoria("3","Lavanderia");
call InsertarCategoria("4","Oficina");
call InsertarCategoria("5","Aseo");
call InsertarCategoria("6","Alimento");

DROP PROCEDURE MostrarCategoria
DELIMITER ##
CREATE PROCEDURE MostrarCategoria()
BEGIN
 SELECT * FROM Categoria;
END ##
DELIMITER ##;

-- ----------------------------------------------------------- --

drop procedure InsertarCargo
DELIMITER ##
create procedure InsertarCargo(
c_id_cargo int(11),
c_nombre_cargo varchar(40))
begin
insert into cargo(id_cargo, nombre_cargo)
values(c_id_cargo, c_nombre_cargo);
end ##
DELIMITER ##;

call InsertarCargo("1","Administrador");
call InsertarCargo("2","Empleado");

DROP PROCEDURE MostrarCargo
DELIMITER ##
CREATE PROCEDURE MostrarCargo()
BEGIN
 SELECT * FROM cargo;
END ##
DELIMITER ##;

-- ----------------------------------------------------------- --

drop procedure InsertarMarca
DELIMITER ##
create procedure InsertarMarca(
c_nombre_marca varchar(40))
begin
insert into marca (nombre_marca)
values (c_nombre_marca);
end ##
DELIMITER ##;

call InsertarMarca('Rimax');
call InsertarMarca('HP');
call InsertarMarca('Genfar');
call InsertarMarca('Diana');
call InsertarMarca('Protex');
call InsertarMarca('Saltin');


drop procedure MostrarMarca
DELIMITER ##
create procedure MostrarMarca()
begin
 select * from marca;
end ##
DELIMITER ##;

-- ----------------------------------------------------------- --

drop procedure InsertarProveedores
DELIMITER ##
create procedure InsertarProveedores(
c_nombre_proveedor varchar(40))
begin
insert into proveedores (nombre_proveedor)
values (c_nombre_proveedor);
end ##
DELIMITER ##;

call InsertarProveedores('Colanta');
call InsertarProveedores('Postobon');
call InsertarProveedores('Jamar');
call InsertarProveedores('Sanofi Aventis');
call InsertarProveedores('Grupo Diana');
call InsertarProveedores('Noel');


drop procedure MostrarProveedores
DELIMITER ##
create procedure MostrarProveedores()
begin
 select * from proveedores;
end ##
DELIMITER ##;

-- ----------------------------------------------------------- --

drop procedure InsertarLoteMedicamento
DELIMITER ##
create procedure InsertarLoteMedicamento(
c_nombre_loteM varchar(40))
begin
insert into lote_medicamento (nombre_loteM)
values (c_nombre_loteM);
end ##
DELIMITER ##;

call InsertarLoteMedicamento('Lote con ibuprofeno');
call InsertarLoteMedicamento('Lote con Acetaminofen');
call InsertarLoteMedicamento('Lote con Aspirina');
call InsertarLoteMedicamento('Lote con noxpirin');

drop procedure MostrarLoteMedicamento
DELIMITER ##
create procedure MostrarLoteMedicamento()
begin
 select * from Lote_medicamento;
end ##
DELIMITER ##;

-- ----------------------------------------------------------- --

drop procedure InsertarLoteAlimento
DELIMITER ##
create procedure InsertarLoteAlimento(
c_nombre_loteA varchar(40))
begin
insert into lote_alimento (nombre_loteA)
values (c_nombre_loteA);
end ##
DELIMITER ##;

call InsertarLoteAlimento('Lote de Pan tajado');
call InsertarLoteAlimento('Lote de Galletas integrales');
call InsertarLoteAlimento('Lote de Arroz');
call InsertarLoteAlimento('Lote de Frijol');

drop procedure MostrarLoteAlimento
DELIMITER ##
create procedure MostrarLoteAlimento()
begin
 select * from Lote_alimento;
end ##
DELIMITER ##;

-- ----------------------------------------------------------- --

drop procedure InsertarProductos
DELIMITER ##
create procedure InsertarProductos(
c_id_producto int(11),
c_nombre_producto varchar (30),
c_cantidad_producto int(11),
c_fecha_registro_producto datetime,
c_fecha_actualizacion_producto datetime,
c_categoria_id int(11),
c_marca_id int(11))
begin
insert into productos(id_producto, nombre_producto, cantidad_producto, fecha_registro_producto, fecha_actualizacion_producto, categoria_id, marca_id)
values(c_id_producto, c_nombre_producto, c_cantidad_producto, c_fecha_registro_producto, c_fecha_actualizacion_producto, c_categoria_id,  c_marca_id);
end ##
DELIMITER ##;

call InsertarProductos (1, "Ibuprofeno", 10, current_timestamp(), current_timestamp(), 2, 3);
call InsertarProductos (2, "Arroz", 5, current_timestamp(), current_timestamp(), 6, 4);
call InsertarProductos (3, "Silla", 8, current_timestamp(), current_timestamp(), 1, 1);
call InsertarProductos (4, "Jabon liquido", 3, current_timestamp(), current_timestamp(), 5, 5);
call InsertarProductos (5, "Computador", 6, current_timestamp(), current_timestamp(), 4, 2);
call InsertarProductos (6, "Mesa", 2, current_timestamp(), current_timestamp(), 1, 4);
call InsertarProductos (7, "Limpido", 3, current_timestamp(), current_timestamp(), 3, 5);
call InsertarProductos (8, "Galletas", 7, current_timestamp(), current_timestamp(), 6, 6);

DROP PROCEDURE MostrarProductos
DELIMITER ##
CREATE PROCEDURE MostrarProductos()
BEGIN
 SELECT * FROM productos;
END ##
DELIMITER ##;

-- ----------------------------------------------------------- --

drop procedure InsertarProductosMedicamento
DELIMITER ##
create procedure InsertarProductosMedicamento(
c_fecha_vencimientoM date,
c_loteM_id int(11),
c_id_producto_medicamento int(11))
begin
insert into medicamento(fecha_vencimientoM, loteM_id, id_producto_medicamento)
values (c_fecha_vencimientoM, c_loteM_id, c_id_producto_medicamento);
end ##
DELIMITER ##;

call InsertarProductosMedicamento("2022-07-18", 1, 1);

drop procedure MostrarProductosMedicamento
DELIMITER ##
create procedure MostrarProductosMedicamento()
begin
select * from medicamento;
end ##
DELIMITER ##;

-- ----------------------------------------------------------- --

drop procedure InsertarProductosAlimento
DELIMITER ##
create procedure InsertarProductosAlimento(
c_fecha_vencimientoA date,
c_loteA_id int(11),
c_id_producto_alimento int(11))
begin
insert into alimento(fecha_vencimientoA, loteA_id, id_producto_alimento)
values (c_fecha_vencimientoA, c_loteA_id, c_id_producto_alimento);
end ##
DELIMITER ##;

call InsertarProductosAlimento("2022-09-20", 3, 2);
call InsertarProductosAlimento("2022-10-27", 2, 8);


drop procedure MostrarProductosAlimento
DELIMITER ##
create procedure MostrarProductosAlimento()
begin
select * from alimento;
end ##
DELIMITER ##;

-- ----------------------------------------------------------- --

drop procedure InsertarUsuarios
DELIMITER ##
create procedure InsertarUsuarios(
c_id_usuario int(11),
c_tipo_documento varchar(10),
c_nombre_usuario varchar (30),
c_apellido_usuario varchar(30),
c_correo varchar(40),
c_contrasena varchar(30),
c_telefono varchar(15),
c_direccion varchar(30),
c_cargo_id int(11),
c_fecha_registro_usuario datetime,
c_fecha_actualizacion_usuario datetime)
begin
insert into usuarios(id_usuario, tipo_documento, nombre_usuario, apellido_usuario, correo, contrasena, telefono, direccion, cargo_id, fecha_registro_usuario, fecha_actualizacion_usuario)
values(c_id_usuario, c_tipo_documento, c_nombre_usuario, c_apellido_usuario, c_correo, c_contrasena, c_telefono, c_direccion, c_cargo_id, c_fecha_registro_usuario, c_fecha_actualizacion_usuario);
end ##
DELIMITER ##;

call InsertarUsuarios(1012238476,"CC","santiago","londoño jimenez","santiagolondono@gmail.com","londoño10","3044329168","Cra 80 #12-32", 2, current_timestamp(), current_timestamp());
call InsertarUsuarios(71330488,"CC","Jorge","giraldo velez","jorgegiraldo@gmail.com","jorge123","3113294239","Cll 58#02-03", 2, current_timestamp(), current_timestamp());
call InsertarUsuarios(1011390270,"CC","mauricio","castaño vergara","mauriciocastano11@gmail.com","","3045729168","Cll 71A#43-126", 2, current_timestamp(), current_timestamp());
call InsertarUsuarios(1001228684,"CC","santiago","gonzalez restrepo","santiagogonzalez@gmail.com","","3046809799","Cra 44#80-46", 2, current_timestamp(), current_timestamp());
call InsertarUsuarios(1027800023,"CC","andres","sanchez garcia","andresanchez200319@gmail.com","","3172185125","Cll 34CC #81-28", 2, current_timestamp(), current_timestamp());
call InsertarUsuarios(1234567890,"CC","Juan","Hernandez Toro","juantoro@gmail.com","toro123","3026503204","Cra 14#40-36", 2, current_timestamp(), current_timestamp());
call InsertarUsuarios(1001237601,"TI","Melany","Giraldo Osorio","melanyosorio@gmail.com","giraldo12","3104723821","Cll 78#23-03", 2, current_timestamp(), current_timestamp());

call InsertarUsuarios(1128414543,"CC","Carlos Andres","Castaño Vergara","hogargeriatricovital@gmail.com","andres12","3128844193","Circular 76 #39B-114",1, current_timestamp(), current_timestamp());
call InsertarUsuarios(45546531,"CC","Angela Maria","Castaño Vergara","anmacave65@gmail.com","angela65","3003759250","Cra 21#42-17",1, current_timestamp(), current_timestamp());

DROP PROCEDURE MostrarUsuarios
DELIMITER ##
CREATE PROCEDURE MostrarUsuarios()
BEGIN
 SELECT * FROM usuarios;
END ##
DELIMITER ##;

-- ----------------------------------------------------------- --

drop procedure InsertarMediaU
DELIMITER ##
create procedure InsertarMediaU(
c_usuario_id int(11),
c_producto_id int(11))
begin
insert into usuarios_productos (usuario_id, producto_id) values (c_usuario_id, c_producto_id);
end ##
DELIMITER ##;

call InsertarMediaU(1001228684, 1);

drop procedure MostrarMediaU
DELIMITER ##
create procedure MostrarMediaU()
begin
select * from usuarios_productos;
end ##
DELIMITER ##;

-- ----------------------------------------------------------- --

drop procedure InsertarMediaP
DELIMITER ##
create procedure InsertarMediaP(
c_proveedor_id int(11),
c_producto_id int(11),
c_fecha_proveedor datetime)
begin
insert into proveedores_productos (proveedor_id, producto_id, fecha_proveedor) values (c_proveedor_id, c_producto_id, c_fecha_proveedor);
end ##
DELIMITER ##;

call InsertarMediaP(4, 1, current_timestamp());
call InsertarMediaP(5, 2, current_timestamp());
call InsertarMediaP(3, 3, current_timestamp());
call InsertarMediaP(4, 4, current_timestamp());
call InsertarMediaP(5, 5, current_timestamp());
call InsertarMediaP(4, 6, current_timestamp());
call InsertarMediaP(4, 7, current_timestamp());
call InsertarMediaP(6, 8, current_timestamp());
call InsertarMediaP(4, 9, current_timestamp());
call InsertarMediaP(4, 10, current_timestamp());

drop procedure MostrarMediaP
DELIMITER ##
create procedure MostrarMediaP()
begin
select * from proveedores_productos;
end ##
DELIMITER ##;

/*Creacion procediminetos almacenados (Borrar/Delete)*/

drop procedure deleteUsuarios
DELIMITER ##
create procedure deleteUsuarios(
d_id_usuario int(11))
begin
delete from usuarios where id_usuario = d_id_usuario;
end ##
DELIMITER ##;

call deleteUsuarios (1012238476);
call deleteUsuarios (71330488);

/*Creacion procedimientos almacenados (Actualizar/Update)*/

drop procedure ActualizarContrasena
DELIMITER ##
create procedure ActualizarContrasena(
a_id_usuario int(11),
a_contrasena varchar (30),
a_fecha_actualizacion_usuario datetime)
begin
update usuarios set contrasena = a_contrasena, fecha_actualizacion_usuario = a_fecha_actualizacion_usuario
where id_usuario = a_id_usuario;
end ##
DELIMITER ##;

call ActualizarContrasena (1011390270,'mauro11', current_timestamp());
call ActualizarContrasena (1001228684,'santiago18', current_timestamp());
call ActualizarContrasena (1027800023,'andres123', current_timestamp());

-- ----------------------------------------------------------- --

drop procedure ActualizarProducto
DELIMITER ##
create procedure ActualizarProducto(
a_id_producto int(11),
a_cantidad_producto int(11),
a_fecha_actualizacion_producto datetime)
begin
update productos set cantidad_producto = a_cantidad_producto, fecha_actualizacion_producto = a_fecha_actualizacion_producto
where id_producto = a_id_producto;
end ##
DELIMITER ##;

call ActualizarProducto (1, 5, current_timestamp());
call ActualizarProducto (2, 2, current_timestamp());
call ActualizarProducto (3, 10, current_timestamp());

/*Creación de vistas*/

create view detalleProductoMedicamento
As
select productos.nombre_producto as 'Nombre', productos.cantidad_producto as 'Cantidad', productos.fecha_registro_producto as 'Fecha registro', productos.fecha_actualizacion_producto as 'Fecha actualización', categoria.nombre_categoria as 'Categoria', marca.nombre_marca as 'Marca', proveedores.nombre_proveedor as 'Proveedor', proveedores_productos.fecha_proveedor as 'Fecha recepción', medicamento.fecha_vencimientoM as 'Fecha de vencimiento', lote_medicamento.nombre_loteM as 'Lote'
from ((((((productos
inner join categoria on categoria.id_categoria = productos.categoria_id)
inner join marca on marca.id_marca = productos.marca_id)
inner join proveedores_productos on productos.id_producto = proveedores_productos.producto_id)
inner join proveedores on proveedores.id_proveedor = proveedores_productos.proveedor_id)
inner join medicamento on medicamento.id_producto_medicamento = productos.id_producto)
inner join lote_medicamento on lote_medicamento.id_loteM = medicamento.loteM_id);

-- ----------------------------------------------------------- --

create view detalleProductoAlimento
As
select productos.nombre_producto as 'Nombre', productos.cantidad_producto as 'Cantidad', productos.fecha_registro_producto as 'Fecha registro', productos.fecha_actualizacion_producto as 'Fecha actualización', categoria.nombre_categoria as 'Categoria', marca.nombre_marca as 'Marca', proveedores.nombre_proveedor as 'Proveedor', proveedores_productos.fecha_proveedor as 'Fecha recepción', alimento.fecha_vencimientoA as 'Fecha de vencimiento', lote_alimento.nombre_loteA as 'Lote'
from ((((((productos
inner join categoria on categoria.id_categoria = productos.categoria_id)
inner join marca on marca.id_marca = productos.marca_id)
inner join proveedores_productos on productos.id_producto = proveedores_productos.producto_id)
inner join proveedores on proveedores.id_proveedor = proveedores_productos.proveedor_id)
inner join alimento on alimento.id_producto_alimento = productos.id_producto)
inner join lote_alimento on lote_alimento.id_loteA = alimento.loteA_id);

-- ----------------------------------------------------------- --

create view detalleProductos
As
select productos.nombre_producto as 'Nombre', productos.cantidad_producto as 'Cantidad', productos.fecha_registro_producto as 'Fecha registro', productos.fecha_actualizacion_producto as 'Fecha actualización', categoria.nombre_categoria as 'Categoria', marca.nombre_marca as 'Marca', proveedores.nombre_proveedor as 'Proveedor', proveedores_productos.fecha_proveedor as 'Fecha recepción'
from ((((productos
inner join categoria on categoria.id_categoria = productos.categoria_id)
inner join marca on marca.id_marca = productos.marca_id)
inner join proveedores_productos on productos.id_producto = proveedores_productos.producto_id)
inner join proveedores on proveedores.id_proveedor = proveedores_productos.proveedor_id);

-- ----------------------------------------------------------- --

create view detalleUsuarios
As
select usuarios.id_usuario as 'Documento', usuarios.tipo_documento as 'Tipo Documento', usuarios.nombre_usuario as 'Nombre', usuarios.apellido_usuario as 'Apellido', usuarios.correo as 'Correo', usuarios.contrasena as 'Contraseña', usuarios.telefono as 'Telefono', usuarios.direccion as 'Dirección', usuarios.fecha_registro_usuario as 'Fecha Registro Empleado', usuarios.fecha_actualizacion_usuario as 'Fecha Actualización Empleado', cargo.nombre_cargo as 'Cargo', productos.nombre_producto as 'Producto Almacenado'
from (((usuarios
inner join cargo on cargo.id_cargo = usuarios.cargo_id)
inner join usuarios_productos on usuarios_productos.usuario_id = usuarios.id_usuario)
inner join productos on productos.id_producto = usuarios_productos.producto_id);

/*Mostrar cantidad total de productos*/

create view Stock
As
Select sum(productos.cantidad_producto) as 'Stock Total'
from productos;

select * from Stock;

drop view Stock;

/*Disparadores (triggers)*/

DELIMITER ##
create trigger hola
before insert
on productos
for each row
begin
insert into usuarios_productos (usuario_id, producto_id) values (1001228684, 5);
end ##
DELIMITER ;

drop trigger hola;

/*Mostrar procedimientos almacenados (select)*/

call MostrarProductos;
call MostrarCategoria;
call MostrarUsuarios;
call MostrarCargo;
call MostrarMarca;
call MostrarProveedores;
call MostrarLoteMedicamento;
call MostrarLoteAlimento;
call MostrarProductosMedicamento;
call MostrarProductosAlimento;
call MostrarMediaU;
call MostrarMediaP;

/*Mostrar vistas*/

select * from detalleProductoMedicamento;
select * from detalleProductoAlimento;
select * from detalleProductos;
select * from detalleUsuarios;

/*Mostrar todas las tablas de la base de datos*/

show tables;

drop database hogarvital;