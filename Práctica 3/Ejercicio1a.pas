{1. Se cuenta con un archivo que almacena información sobre especies de plantas originarias de
Europa, de cada especie se almacena: código especie, nombre vulgar, nombre científico, altura
promedio, descripción y zona geográfica.

El archivo no está ordenado por ningún criterio.
Realice un programa que elimine especies de plantas trepadoras. Para ello se recibe por
teclado los códigos de especies a eliminar.

a. Implemente una alternativa para borrar especies, que inicialmente marque los
registros a borrar y posteriormente compacte el archivo, creando un nuevo archivo
sin los registros eliminados.
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

a. Implemente una alternativa para borrar especies, que inicialmente marque los
registros a borrar y posteriormente compacte el archivo, creando un nuevo archivo
sin los registros eliminados.
}
    assign(archivo, 'archivoPlantas');
    assign(archivoNuevo, 'archivoPlantasNuevo');
    reset(archivo);
    rewrite(archivoNuevo);

    writeln('Ingrese codigo de especie a eliminar: ');
    readln(eliminarCod);

    // copio archivo registros previos a las plantas trepadoras con codigo indicado a eliminar
    while (not EOF(archivo)) do begin
          leer(archivo,reg);
          while (reg.cod <> eliminarCod) and (reg.cod <> valorAlto) do begin
                leer(archivo, reg);
          end;

          if (reg.cod <> valorAlto) then begin// si sale porque encontró el codigo
             pos:= (filepos(archivo) - 1); // guardo posición a eliminar
             reg.nombre_vulgar:= '***';    // lo marco
             seek(archivo, pos);           // me posiciono para
             write(archivo, reg);          // escribo en esa posicion el registro con la marca
          end;

          seek(archivo, 0);                // me posiciono al principio para buscar el prox cod
          writeln('Ingrese codigo de especie a eliminar: ');
          readln(eliminarCod);
    end;

    // creo el nuevo archivo con los registros que no estan marcados
    leer(archivo, reg);
    while (reg.cod <> valorAlto) do begin
          if (reg.nombre_vulgar <> '***') then
             write(archivoNuevo, reg);
          leer(archivo, reg);
    end;

    close(archivo);
    close(archivoNuevo);

end.

