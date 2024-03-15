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
    arch = file of Integer;
var
    archivo:arch;
begin
    assgin(archivo, 'C:\Users\Dolores\Documents\Facultad\Conceptos de Bases de Datos\Práctica 1\libros.txt');
    rewrite(archivo);



    close(archivo);
end.
