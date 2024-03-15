{6. Realizar un programa que permita:
a. Crear un archivo binario a partir de la información almacenada en un
archivo de texto. El nombre del archivo de texto es: “libros.txt”
b. Abrir el archivo binario y permitir la actualización del mismo. Se debe poder
agregar un libro y modificar uno existente. Las búsquedas se realizan por
ISBN.

NOTA: La información en el archivo de texto consiste en: ISBN (nro de 13 dígitos),
título del libro, género, editorial y año de edición. Cada libro se almacena en tres líneas
en el archivo de texto. La primera línea contendrá la información de ISBN y título del
libro, la segunda línea almacenará el año de edición y la editorial y en la tercera línea el
género del libro. (Analice otras posibles formas de representar la información en el txt)

}

program Ejercicio6;
uses
    crt;
type
    libro = record
           nombre:string[20];
           ISBN: string[10];
           genero:string[20];
           editorial:string[20];
           anio:Integer;
    end;

    arch = file of libro;
var
    archivo:Text;
    archBinario: arch;
    l:libro;
begin
    assign(archBinario, 'numeros.bin');
    reset(archBinario); // abro archivo binario para lectura
    assign(archivo, 'libros.txt');
    rewrite(archivo); // creo archivo de texto

    while(not EOF(archBinario)) do begin
        Read(archBinario, l);
        WriteLn(archivo, l.ISBN, l.nombre);
        Writeln(l.anio, l.editorial);
        Writeln(l.genero);
    end;

    close(archivo);
    close(archBinario);
    writeln('Se copio el archivo binario en el archivo de texto "libros.txt"');


    readln();
end.
