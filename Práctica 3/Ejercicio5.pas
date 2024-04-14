{5. Se cuenta con un archivo de artículos deportivos a la venta. De cada artículo se almacena: nro de
artículo, descripción, color, talle, stock disponible y precio del producto.

Se reciben por teclado los nros de artículos a eliminar, ya que no se fabricarán más.
Se deberá realizar la baja lógica de los artículos correspondientes.
Además, se requiere listar en un archivo de texto todos los artículos eliminados,
para ello debe almacenar toda la información del artículo eliminado en el archivo de
texto. (No debe recorrer nuevamente el archivo maestro, deberá hacerlo en simultáneo).

Escriba el programa principal con la declaración de tipos necesaria y realice un proceso que
reciba el archivo maestro y actualice el archivo maestro a partir de los códigos de artículos a
borrar. El archivo maestro se encuentra ordenado por el código de artículo.}

program Ejercicio5;
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


// ---------------- PROGRAMA PRINCIPAL ----------------
var
    archivo:archivoArticulos;
begin
     assign(archivo, 'archivoArticulos');
     eliminarArticulos(archivo);
end.
