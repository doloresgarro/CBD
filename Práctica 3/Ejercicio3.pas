{ 3. Una tienda de indumentaria desea almacenar sus productos en un archivo de datos
para la posterior actualización de stock con las compras y ventas de indumentario.
Para ello cuenta con un archivo de texto donde tiene almacenada la siguiente
información: código de producto, nombre, descripción y stock.

a. Deberá realizar un procedimiento que tomando como entrada el archivo de texto,
genere el correspondiente archivo binario de datos. }

program Ejercicio3;
const
     valorAlto = 999999;
     MARCA = -1;
type
    info = record
         cod: integer;
         nombre: string[20];
         descripcion: string[20];
         stock: integer;
    end;

    archivoProductos = file of info;

// ------------------ PROCEDIMIENTOS ------------------ 

procedure crearArchivoBinario(var archivoTexto:text; var archivoBinario:archivoProductos);
var
   reg:info;
begin
     rewrite(archivoBinario);  // creo arch binario
     reset(archivoTexto);      // abro arch texto

     while (not EOF(archivoTexto)) do begin
           readln(archivoTexto, reg.cod);
           readln(archivoTexto, reg.nombre); // lee un registro y lo copia en el arch binario
           readln(archivoTexto, reg.descripcion);
           readln(archivoTexto, reg.stock);
           write(archivoBinario, reg);
     end;

     close(archivoBinario);
     close(archivoTexto);
end;


{b. Se reciben por pantalla códigos de indumentaria obsoletos, los cuales deben
eliminarse del archivo de datos, utilizando una marca de borrado. La marca de
borrado consiste en poner valor negativo al stock. Realice el procedimiento
correspondiente}

procedure eliminarCodigos(var archivo:archivoProductos);
var
    eliminarCod, pos: integer;
    reg:info;
begin
     reset(archivoBinario);

     writeln('Ingrese codigo a eliminar: ');
     readln(eliminarCod);

     while (not EOF(archivo)) and (reg.cod <> eliminarCod) do begin  // mientras no se termine y no encuentre el cod a eliminar
           read(archivo, reg);                                       // lee un registro
     end:

     if (reg.cod = eliminar.cod) then begin
        pos:= filepos(archivo) - 1;                                  // guardo pos a marcar
        reg.stock:= MARCA;                                           // pongo en negativo el stock
        seek(archivo, pos);
        write(archivo, reg);                                         // marco para luego eliminar
     end;

     close(archivo);
end;


{c. A continuación, se solicita realizar un procedimiento que permita realizar
el alta de una nueva indumentaria con los valores obtenidos por teclado.}

procedure leerIndumentaria(var reg:info);
begin
   writeln('Ingrese codigo: ');
   readln(reg.codigo);
   writeln('Ingrese nombre: ');
   readln(reg.nombre);
   writeln('Ingrese descripcion: ');
   readln(reg.descripcion);
   writeln('Ingrese stock: ');
   readln(reg.stock);
end

procedure agregarNuevaIndumentaria(var archivo:archivoProductos);
var
    nuevaIndumentaria:info;
begin
     leerIndumentaria(nuevaIndumentaria);
     reset(archivoBinario);
     seek(archivo, filesize(archivo));
     write(archivo, reg);
     close(archivo);
end;

{d. Realice un nuevo procedimiento de baja, suponiendo que la creación del
archivo supuso la utilización de la técnica de lista invertida para reutilización
de espacio (dejó un registro obsoleto al comienzo del archivo como cabecera de
lista).}
procedure eliminarIndumentariaLI(var archivo: archivoProductos);
var
   eliminarInd, pos:integer;
   sLibre, reg:info;
begin
     reset(archivo);
     writeln('Ingrese codigo de indumentaria a eliminar: ');
     readln(eliminarInd);

     // leo cabecera
     read(archivo, sLibre);

     while (eliminarInd.cod <> MARCA) and (not EOF(archivo)) do begin
           read(archivo, reg);
     end;

     if (eliminarInd.cod = MARCA) then begin
        nLibre:= filepos(archivo) - 1;      // guardo pos a eliminar
        seek(archivo, nLibre);              // me posiciono ahi
        write(archivo, sLibre);             // grabo contenido de la cabecera
        str(nLibre, sLibre);                // convierte de number a string
        seek(archivo, 0);                   // me posiciono en cabecera
        write(archivo, sLibre);             // actualizo cabecera
     end
     else
          writeln('No se encontro la indumentaria que desea eliminar');

     close(archivo);
end;


{e. Re implemente c, sabiendo que se utiliza la técnica de lista en invertida}
procedure agregarIndumentariaLI(var archivo:archivoProductos; nuevaInd:info);
var
   nuevaInd:info;
   sLibre: info;
   nLibre:integer;
   cod:integer;
begin
     reset(archivo);

     read(archivo, sLibre);
     val(sLibre, nLibre, cod);              // convierte de string a number

     if (nLibre = -1) then
        seek(archivo, filesize(archivo));   // si no hay espacio libre lo coloca al final
     else begin
          seek(archivo, nLibre);            // me posiciono donde hay lugar
          read(archivo, sLibre);            // lee contenido en esa pos
          seek(archivo, 0);                 // se posiciona al principio
          write(archivo, sLibre);           // reescribe cabecera
          seek(archivo, nLibre);            // me posiciono en donde hay lugar
     end;

     write(archivo, nuevaInd);              // escribo indumentaria en la pos libre
     close(archivo);
end;

{f. Re implementa a, para poder utilizar la técnica de lista invertida}

procedure crearArchivoBinario_listaInvertida(var archivoTexto:text; var archivoBinario:archivoProductos);
var
   reg:info;
begin
     while (not EOF(archivoTexto)) do begin
           readln(archivoTexto, reg.cod);
           readln(archivoTexto, reg.nombre);
           readln(archivoTexto, reg.descripcion);
           readln(archivoTexto, reg.stock);
           agregarIndumentariaLI(archivoBinario, reg);
     end;

end;


// ------------------ PROGRAMA PRINCIPAL ------------------
var
   archivoTexto: text;
   archivoBinario:archivoProductos;

begin

     assign(archivoBinario, 'archivoBinario.bin');
     assign(archivoTexto, 'architoTexto.txt');   

     crearArchivoBinario(archivoTexto, archivoBinario);

     eliminarCodigos(archivoBinario);

     agregarNuevaIndumentaria(archivoBinario);

     eliminarIndumentariaLI(archivoBinario);

     agregarIndumentariaLI(archivoBinario, ind);

     crearArchivoBinario_listaInvertida(archivoTexto, archivoBinario);

end.

