{1. Se cuenta con un archivo que almacena información sobre especies de plantas originarias de
Europa, de cada especie se almacena: código especie, nombre vulgar, nombre científico, altura
promedio, descripción y zona geográfica.

El archivo no está ordenado por ningún criterio.
Realice un programa que elimine especies de plantas trepadoras. Para ello se recibe por
teclado los códigos de especies a eliminar.

b. Implemente otra alternativa donde para quitar los registros se deberá copiar el
último registro del archivo en la posición del registro a borrar y luego eliminar del
archivo el último registro de forma tal de evitar registros duplicados.
Nota: Las bajas deben finalizar al recibir el código 100000
}

program Ejercicio1;
const
     valorAlto = 9999;
type
    planta = record
            cod, altura, promedio: integer;
            especie, nombre_vulgar, nombre_cientifico, descripcion, zona: string[20];
    end;
    archivoPlantas = file of planta;

procedure leer(var archivo:archivoPlantas; var dato:planta);
begin
    if (not EOF(archivo)) then
       read(archivo, dato)
    else
        dato.cod:= valorAlto;
end;

var
    archivo, archivoNuevo:archivoPlantas;
    reg: planta;
    eliminarCod, pos: integer;
begin
{
El archivo no está ordenado por ningún criterio.
Realice un programa que elimine especies de plantas trepadoras. Para ello
se recibe por teclado los códigos de especies a eliminar.

b. Implemente otra alternativa donde para quitar los registros se deberá copiar el
último registro del archivo en la posición del registro a borrar y luego eliminar del
archivo el último registro de forma tal de evitar registros duplicados.
Nota: Las bajas deben finalizar al recibir el código 100000
}
    assign(archivo, 'archivoPlantas');
    reset(archivo);

    writeln('Ingrese codigo de especie a eliminar: ');
    readln(eliminarCod);

    {copiar el último registro del archivo en la posición del registro a borrar y luego eliminar del
    archivo el último registro }
    while (not EOF(archivo)) and (eliminarCod <> 10000) do begin
          leer(archivo,reg);
          while (reg.cod <> eliminarCod) and (reg.cod <> valorAlto) do begin
                leer(archivo, reg);
          end;

          if (reg.cod <> valorAlto) then begin           // si sale porque encontró el codigo
             pos:= (filepos(archivo) - 1);               // guardo posición a eliminar
             seek(archivo, filesize(archivo) - 1);       // me posiciono en el ult registro del archivo
             leer(archivo, reg);                         // copio ultimo registro
             seek(archivo, pos);                         // me posiciono en la pos del codigo a eliminar
             write(archivo, reg);                        // escribo en esa posicion el registro de la ult pos
             seek(archivo, filesize(archivo) - 1);       // me posiciono al final para eliminar ult registro
             truncate(archivo);
          end;

          seek(archivo, 0);                              // me posiciono al principio para buscar el prox cod
          writeln('Ingrese codigo de especie a eliminar: ');
          readln(eliminarCod);
    end;

    close(archivo);

end.
