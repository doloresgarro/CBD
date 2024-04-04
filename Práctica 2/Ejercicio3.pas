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
    regDetalle = record
          codigo_calzado:string[5];
          numero:integer;
          cantidad_vendida:integer;
    end;

    regMaestro = record
          codigo_calzado:string[5];
          numero:integer;
          descripcion:string[20];
          precio:integer; // unitario
          color:string[20];
          stock_producto:integer; // stock de cada producto
          stock_minimo:integer; // stock minimo

    end;

    archivoDetalle = file of regDetalle;
    archMaestro = file of regMaestro;

    vectorArchDetalle = array [1..N] of archivoDetalle;
    registrosDetalle = array [1..N] of regDetalle;

// ------------------- PROCEDIMIENTOS -------------------
{procedure crearArchivoMaestro(var archivo: archMaestro);
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


procedure crearArchivoDetalle(var detalle:vectorArchDetalle);
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
end;     }

{registrosD --> arreglo de registros detalle. Recorro el arch detalle y voy
 almacenando en cada pos del arreglo un registro }

procedure leer(var archivo:archivoDetalle; var dato:regDetalle);
begin
   if not(EOF(archivo)) then
      read(archivo, dato)
   else
       dato.codigo_calzado:= valorAlto;
end;


procedure minimo(var registrosD: registrosDetalle; var archivosD:vectorArchDetalle; var min:registrosDetalle);
var
   i, posMin: integer;
begin
     posMin:= 1;
     min:= registrosD[posMin];
     for i:= 2 to N do begin
         if (min.codigo_calzado > registrosD[i].codigo_calzado) then begin
            min:= archivosD[posMin];
            posMin:= i;
         end;
     end;
     leer(archivosD[posMin], registrosD[posMin]); // para el proximo minimo
end;


procedure actualizarMaestro(var maestro: archMaestro; var archivos_detalle: vectorArchDetalle; var archTexto:Text; var registrosD:registrosDetalle);
var
   aux,min:regDetalle;
   m: regMaestro;
   i:integer;
begin

     minimo(registrosD, vectorArchsDetalle, min);
     if (not EOF(maestro)) then
        read(maestro, m);

        {Además, se deberá informar qué calzados no tuvieron ventas y cuáles quedaron por
debajo del stock mínimo. Los calzados sin ventas se informan por pantalla, mientras
que los calzados que quedaron por debajo del stock mínimo se deben informar en un
archivo de texto llamado calzadosinstock.txt.
Nota: tenga en cuenta que no se realizan ventas si no se posee stock.}
     while (min.codigo_calzado <> valorAlto) do begin   // mientras no se termine el arch detalle

           while (regM.codigo_calzado <> min.codigo_calzado)and (aux.numero = min.numero) do   // leo arch maestro hasta encontrar el codigo min
                 read(maestro, m);

           aux.codigo_calzado:= min.codigo_calzado;
           while (aux.codigo_calzado = min.codigo_calzado) do begin // deberia ser un while junto de cod y num?
                 aux.numero:= d.numero;

                 while (aux.codigo_calzado = min.codigo_calzado) and (aux.numero = min.numero) do begin
                     if (min.cantidad_vendida = 0) then
                        writeln('El calzado ', m.codigo_calzado, ' no tuvo ventas')
                     else begin
                         if (m.stock_minimo > m.stock_producto - min.cantidad_vendida) then begin
                            m.stock_producto:= m.stock_producto - min.cantidad_vendida;  // actualizo arch maestro
                            writeln(archTexto, min.codigo_calzado); // escribo en arch de texto calzado q no tiene mas stock
                         end;
                     end
                 end;
                 minimo(registrosD, vectorArchsDetalle, min);
           end;
           // me posiciono en la ult pos del maestro y copio info
           seek(maestro, filepos(maestro)-1);
           write(maestro, m);
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
   maestro: archMaestro;  // archivo maestro
   archivos_detalle: vectorArchDetalle; // arreglo de archivos detalle
   registrosD:vectorRegistrosDetalle;  // arreglo de registros detalle
   i:integer;
   archTexto:Text;
begin



   assign(maestro, 'maestro.dat');
   reset(maestro);
   for i:=1 to N do begin
      assign(archivos_detalle[i], 'detalle' + i);
      reset(archivos_detalle[i]);
      leer(archivos_detalle[i], registrosD[i]); // ---
   end;

   assign(archTexto, 'calzadosinstock.txt');
   rewrite(archTexto);

   actualizarMaestro(maestro, archivos_detalle, archTexto, registrosD);

   close(maestro);
   close(archTexto);
   for i:=0 to N do begin
      close(detalles[i]);
   end;

end.
