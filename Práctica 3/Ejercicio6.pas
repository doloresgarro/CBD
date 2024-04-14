{6. Modificar el programa del ejercicio anterior (ejercicio 5) agregándole opciones para:
a. Efectivizar las bajas compactando el archivo. Para esto debe copiar el archivo sin
los registros borrados lógicamente, eliminar el archivo viejo y renombrar el nuevo
con el nombre original.}

program Ejercicio6;
const
     FIN = -1;
type
    articulo = record
             num:integer;
             descripcion:string[20];
             color:string[20];
             talle:integer;
             stock:integer;
             precio:integer;
    end;

    archivoArticulos = file of articulos;

// ---------------- PROCEDIMIENTOS ----------------

procedure eliminarArticulos(var archivo: archivoArticulos);
var
   eliminarArticulo:integer;
   eliminados:text;
   reg:articulos;
begin
     reset(archivo);

     assign(eliminados, 'articulosEliminados.txt');
     rewrite(eliminados);

     writeln('Ingrese numero de articulo a eliminar');
     readln(eliminarArticulo);
     while (eliminarArticulo <> FIN) do
           seek(archivo, 0);
           while (not EOF(archivo)) and (reg.num <> eliminarArticulo) and (reg.num >= eliminarArticulo) do begin  // preg si ult condicion esta bien
                 read(archivo, reg)
           end;

           if (reg.num = eliminarArticulo) then begin
              pos:= filepos(archivo) - 1;
              reg.stock = 0;
              seek(archivo, pos);
              write(archivo, reg);
              // en un archivo de texto listo los eliminados
              writeln(eliminados, reg.num, reg.talle, reg.stock, reg.precio, reg.descripcion);
              writeln(eliminados, reg.color);
              { RECORDAR: en arch de texto siempre se debe utilizar WRITELN y también
              IMPORTANTE!!! --> por linea puede haber un UNICO string y debe ser lo ultimo en esa linea
              descripcion --> ultimo en 1era linea, color --> ultimo en segunda linea }
           end;
           writeln('Ingrese numero de articulo a eliminar');
           readln(eliminarArticulo);
     end;
     close(archivo);
end;


procedure leer(var archivo:archivoArticulos; var dato:articulo);
begin
    if (not EOF(archivo)) then
       read(archivo, dato)
    else
        dato.num:= valorAlto;
end;

procedure eliminarSinStock(var archivo:archivoArticulos);
var
    archivoNuevo:archivoArticulos;
    reg:articulo;
begin
     assign(archivoNuevo, 'archivoNuevo');
     rewrite(archivoNuevo);
     reset(archivo);

     leer(archivo, reg);
     while(reg.num <> valorAlto) do begin
         if (reg.stock <> 0) then
            write(archivoNuevo, reg);
         leer(archivo, reg);
     end;

     close(archivoNuevo);
     close(archivo);

end;


// ---------------- PROGRAMA PRINCIPAL ----------------
var
    archivo:archivoArticulos;
begin
     assign(archivo, 'archivoArticulos');
     eliminarArticulos(archivo);
end.
