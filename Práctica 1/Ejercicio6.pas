{6. Realizar un programa que permita:
a. Crear un archivo binario a partir de la información almacenada en un
archivo de texto. El nombre del archivo de texto es: “libros.txt”
b. Abrir el archivo binario y permitir la actualización del mismo. Se debe poder
agregar un libro y modificar uno existente. Las búsquedas se realizan por
ISBN.
}

program Ejercicio6;
uses
    crt;
type
    libro = record
           nombre:string[20];
           ISBN: string[10];
    end;

    arch = file of libro;
var
    archivo:Text;
    archBinario: arch;
    l:libro;
begin
    assign(archBinario, 'C:\Users\Dolores\Documents\Facultad\Conceptos de Bases de Datos\Prácticas\Práctica 1\ numeros.bin');
    reset(archBinario); // abro archivo binario para lectura
    assign(archivo, 'C:\Users\Dolores\Documents\Facultad\Conceptos de Bases de Datos\Práctica 1\libros.txt');
    rewrite(archivo); // creo archivo de texto

    while(not EOF(archBinario)) do begin
        Read(archBinario, l);
        WriteLn(archivo, l.nombre, l.ISBN);
    end;

    close(archivo);
    close(archBinario);
    writeln('Se copio el archivo binario en el archivo de texto "libros.txt"');
    readln();
end.
