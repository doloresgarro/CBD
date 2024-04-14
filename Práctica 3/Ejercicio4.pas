{4. Una disquera cuenta con un archivo conteniendo la informaci�n de discos(cd) que posee a la
venta. De cada cd se conoce: un c�digo �nico, nombre �lbum, g�nero,artista una descripci�n
asociada, a�o de edici�n y cantidad de copias en stock. Al archivo no tiene orden.
Trimestralmente la disquera actualiza el archivo modificando los discos de los que ya no posee
stock. Implementar un procedimiento que modifique el stock a 0 de los discos obsoletos e informe
por pantalla nombre de �lbumes que quedaron sin stock. Se deber� adem�s declarar los tipos de
datos necesarios y la llamada al procedimiento de modificaci�n. Para ello el usuario ingresar� por
teclado los c�digos de cd que ya no tienen stock.
Adem�s, se deber� implementar la compactaci�n del archivo, es decir un procedimiento que
reciba el archivo de discos y elimine f�sicamente los discos que no tienen stock.
}
program Ejercicio4;
const
     FIN = -1;
     MARCA = '@';
type
    disco = record
          cod,anio_edicion, stock:integer;
          nombre, genero, artista, descripcion:string[20];
    end;

    archivoDiscos = file of disco;

// -----------------  PROCEDIMIENTOS -----------------  

procedure modificarStock(var archivo: archivoDiscos);
var
   reg: disco;
   pos, eliminarCod:integer;
begin
     reset(archivo);

     writeln('Ingrese codigo de disco a modificar el stock: ');
     readln(eliminarCod);
     while (eliminarCod <> FIN) do begin
          seek(archivo, 0);               // como es un nuevo cod me posiciono al principio para buscarlo
          while (not EOF(archivo)) and (eliminarCod <> reg.cod) do begin
                 read(archivo, reg);  // -------------------------
          end;

          if (eliminarCod = reg.cod) then begin
             writeln('El album ' , reg.nombre , 'no tiene m�s stock');
             pos:= filepos(archivo) - 1;
             reg.stock = 0;               // modifico el stock
             seek(archivo, pos);          // me posiciono en la pos
             write(archivo, reg);         // modifico el stock de ese disco
          end
          else
              writeln('No se encontro el codigo del disco a eliminar');

          writeln('Ingrese codigo de disco a modificar el stock: ');
          readln(eliminarCod);
     end;
     close(archivo);
end;

procedure leer(var archivo:archivoDiscos; var dato:disco);
begin
    if (not EOF(archivo)) then
       read(archivo, dato)
    else
        dato.cod:= valorAlto;
end;

procedure eliminarDiscosSinStock(var archivo:archivoDiscos);
var
    archivoNuevo:archivoDiscos;
    reg:disco;
begin
     assign(archivoNuevo, 'archivoNuevo');
     rewrite(archivoNuevo);               // creo archivo donde voy a almacenar discos que tienen stock
     reset(archivo);                      // abro archivo viejo

     leer(archivo, reg);
     while(reg.cod <> valorAlto) do begin
         if (reg.stock <> 0) then
            write(archivoNuevo, reg);
         leer(archivo, reg);
     end;

     close(archivoNuevo);
     close(archivo);

     erase(archivo); // elimino el archivo original
     rename(archivoNuevo, 'archivoDiscos'); // renombro el nuevo archivo con el nombre del archivo original

end;


// -----------------  PROGRAMA PRINCIPAL -----------------
var
   archivo: archivoDiscos;
   reg:disco;
begin
     assign(archivo, 'archivoDiscos');

     modificarStock(archivo);
     eliminarDiscosSinStock(archivo);

end.
