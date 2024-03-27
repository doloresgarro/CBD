{3. Una zapatería cuenta con 20 locales de ventas. Cada local de ventas envía un listado
con los calzados vendidos indicando: código de calzado, número y cantidad vendida
del mismo.

El archivo maestro almacena la información de cada uno de los calzados que se
venden, para ello se registra el código de calzado, número, descripción, precio unitario,
color, el stock de cada producto y el stock mínimo.

Escriba el programa principal con la declaración de tipos necesaria y realice un
proceso que reciba los 20 detalles y actualice el archivo maestro con la información
proveniente de los archivos detalle. Tanto el maestro como los detalles se encuentran
ordenados por el código de calzado y el número.

Además, se deberá informar qué calzados no tuvieron ventas y cuáles quedaron por
debajo del stock mínimo. Los calzados sin ventas se informan por pantalla, mientras
que los calzados que quedaron por debajo del stock mínimo se deben informar en un
archivo de texto llamado calzadosinstock.txt.
Nota: tenga en cuenta que no se realizan ventas si no se posee stock.}

program Ejercicio3;
const
     valorAlto = '99999';
     N = 20;
type
    datosVentas = record
          codigo_calzado:string[5];
          numero:integer;
          cantidad_vendida:integer;
    end;

    archLocales = file of datosVentas;
    vectorLocales = array [1..N] of arhcLocales;

    regMaestro = record
          codigo_calzado:string[5];
          numero:integer;
          descripcion:string[20];
          precio:integer; // unitario
          color:string[20];
          stock_producto:integer: // stock de cada producto
          stock_minimo:integer; // stock minimo

    end;

    archMaestro = file of regMaestro;


// ------------------- PROCEDIMIENTOS -------------------
procedure crearArchivoMaestro(var archivo: archMaestro);
var
	d: datos;
begin
	writeln('Ingrese el codigo de calzado (-1 para finalizar): ');
    readln(d.codigo_calzado);
	while(d.codigo_calzado <> -1) do begin
		writeln('Ingrese el numero: ');
        readln(d.numero);
		writeln('Ingrese descripcion: ');
        readln(d.descripcion);
		writeln('Ingrese el precio: ');
        readln(d.precio);
		writeln('Ingrese el color: ');
        readln(d.color);
		write(archivo, d);
		writeln('Ingrese el stock del producto ');
        readln(d.stock_producto);
        writeln('Ingrese el stock minimo del producto ');
        readln(d.stock_minimo);

        write(archivo, d);
	end;
	close(archivo);
end;


procedure crearArchivoDetalle(var detalle:vectorLocales);
var
   d:datosVentas;
begin
   for i:=0 to N do begin
       assign(detalle[i], 'detalle' + IntToStr(i) + '.dat'));
       rewrite(detalle[i]); // creo archivo detalle

       writeln('Ingrese el codigo de calzado (-1 para finalizar): ');
       readln(d.codigo_calzado);
	   while(d.codigo_calzado <> -1) do begin
		  writeln('Ingrese el numero: ');
          readln(d.numero);
          writeln('Ingrese cantidad vendida: ');
          readln(d.cantidad_vendida);

          write(detalle[i], d);
       end;
       close(detalle[i]);
   end;
end;

procedure leer(var archivo:archLocales; var dato:datosVentas);
begin
   if not(EOF(archivo)) then
      read(archivo, dato)
   else
       dato.codigo_calzado:= valorAlto;
end;

function devuelveMin(v: vectorLocales): integer;
var
   i, valorMin, indiceMin: integer;
begin
	valorMin:= v[1].codigo_calzado;
	indiceMin:= 1;

	for i:=1 to N do begin
		if (v[i].codigo_calzado < valorMin) then begin
			valorMin:=v[i].codigo_calzado;
			indiceMin:= i;
		end;
	end;
	devuelveMin:= indiceMin;
end;

procedure minimo(var r: vectorLocales; var min: datosVentas; var det:vectorLocales);
var
   i: integer;
begin
	i:= devuelveMin(r);
	min:= r[i];
	leer(det[i], regd[i]);
end;


{Tanto el maestro como los detalles se encuentran
ordenados por el código de calzado y el número.
}
procedure actualizarMaestro(var maestro: archMaestro; var detalles: vectorLocales);
var
   d,aux:datosVentas;
   m: regMaestro;
   i:integer;
begin
     read(maestro, m);
     minimo(detalles, );
     while (d.codigo_calzado <> valorAlto) do begin
           aux.codigo_calzado:= d.codigo_calzado;

           while (aux.codigo_calzado = d.codigo_calzado) do begin
                 aux.numero:= d.numero;

                 while (aux.codigo_calzado = d.codigo_calzado) and ( aux.numero = d.numero;) do begin

                 end;
           end;
     end;
end;

{
Escriba el programa principal con la declaración de tipos necesaria y realice un
proceso que reciba los 20 detalles y actualice el archivo maestro con la información
proveniente de los archivos detalle. Tanto el maestro como los detalles se encuentran
ordenados por el código de calzado y el número.
}

// ------------------- PROGRAMA PRINCIPAL -------------------
var
   maestro: archMaestro;
   detalles: vectorLocales; // arreglo de archivos detalle
   i:integer;
begin
   // creo archivo maestro y detalles para probar el programa
   assign(maestro, 'maestro.dat');
   rewrite(maestro);
   crearArchivoMaestro(maestro);
   crearArchivosDetalle(detalles);

   reset(maestro);
   for i:=0 to N do begin
      reset(detalles[i]);
   end;

   actualizarMaestro(maestro, detalles);



   close(maestro);
   for i:=0 to N do begin
      close(detalles[i]);
   end;

end.
