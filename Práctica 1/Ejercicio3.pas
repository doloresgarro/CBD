{3. Realizar un programa que permita crear un archivo de texto. El archivo se debe
cargar con la información ingresada mediante teclado. La información a cargar
representa los tipos de dinosaurios que habitaron en Sudamérica. La carga finaliza
al procesar el nombre ‘zzz’ que no debe incorporarse al archivo.}

program Ejercicio3;
uses
  SysUtils;
const
     FIN = 'zzz';
type
    arch = file of string[20];
var
   archivo:arch;
   nombre:string[20];
begin
   assign(archivo, 'C:\Users\Dolores\Documents\Facultad\Conceptos de Bases de Datos\Práctica 1\dinosaurios.txt');
   rewrite(archivo);

   writeln('Ingrese nombre de dinosaurio: ');
   readln(nombre);
   while (nombre <> FIN) do begin
         write(archivo, nombre);
         writeln('Ingrese nombre de dinosaurio: ');
         readln(nombre);
   end;
   close(archivo);

   writeln('Se creo el archivo "dinosaurios.txt"');

   readln();
end.
