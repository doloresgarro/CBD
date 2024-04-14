{1. Se cuenta con un archivo que almacena informaci�n sobre especies de plantas originarias de
Europa, de cada especie se almacena: c�digo especie, nombre vulgar, nombre cient�fico, altura
promedio, descripci�n y zona geogr�fica.

El archivo no est� ordenado por ning�n criterio.
Realice un programa que elimine especies de plantas trepadoras. Para ello se recibe por
teclado los c�digos de especies a eliminar.

b. Implemente otra alternativa donde para quitar los registros se deber� copiar el
�ltimo registro del archivo en la posici�n del registro a borrar y luego eliminar del
archivo el �ltimo registro de forma tal de evitar registros duplicados.
Nota: Las bajas deben finalizar al recibir el c�digo 100000
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
El archivo no est� ordenado por ning�n criterio.
Realice un programa que elimine especies de plantas trepadoras. Para ello
se recibe por teclado los c�digos de especies a eliminar.

b. Implemente otra alternativa donde para quitar los registros se deber� copiar el
�ltimo registro del archivo en la posici�n del registro a borrar y luego eliminar del
archivo el �ltimo registro de forma tal de evitar registros duplicados.
Nota: Las bajas deben finalizar al recibir el c�digo 100000
}
    assign(archivo, 'archivoPlantas');
    reset(archivo);

    writeln('Ingrese codigo de especie a eliminar: ');
    readln(eliminarCod);

    {copiar el �ltimo registro del archivo en la posici�n del registro a borrar y luego eliminar del
    archivo el �ltimo registro }
    while (not EOF(archivo)) and (eliminarCod <> 10000) do begin
          leer(archivo,reg);
          while (reg.cod <> eliminarCod) and (reg.cod <> valorAlto) do begin
                leer(archivo, reg);
          end;

          if (reg.cod <> valorAlto) then begin           // si sale porque encontr� el codigo
             pos:= (filepos(archivo) - 1);               // guardo posici�n a eliminar
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
