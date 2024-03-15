{6. Realizar un programa que permita:
a. Crear un archivo binario a partir de la informaci�n almacenada en un
archivo de texto. El nombre del archivo de texto es: �libros.txt�
b. Abrir el archivo binario y permitir la actualizaci�n del mismo. Se debe poder
agregar un libro y modificar uno existente. Las b�squedas se realizan por
ISBN.

NOTA: La informaci�n en el archivo de texto consiste en: ISBN (nro de 13 d�gitos),
t�tulo del libro, g�nero, editorial y a�o de edici�n. Cada libro se almacena en tres l�neas
en el archivo de texto. La primera l�nea contendr� la informaci�n de ISBN y t�tulo del
libro, la segunda l�nea almacenar� el a�o de edici�n y la editorial y en la tercera l�nea el
g�nero del libro. (Analice otras posibles formas de representar la informaci�n en el txt)

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
