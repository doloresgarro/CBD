{2. Desarrollar un programa que permita la apertura de un archivo de números enteros
no ordenados. La información del archivo corresponde a la cantidad de votantes
de cada ciudad de la provincia de buenos aires en una elección presidencial.
Recorriendo el archivo una única vez, informe por pantalla la cantidad mínima y
máxima de votantes. Además durante el recorrido, el programa deberá listar el
contenido del archivo en pantalla. El nombre del archivo a procesar debe ser
proporcionado por el usuario.
}
program Ejercicio2;
uses
  SysUtils;

const
  CANTIDAD_NUMEROS = 5;

type
    arch = file of Integer;
var
  archivo:arch;
  i, max, min: Integer;
  numero: Integer;

begin
   max:= -1;
   min:= 9999;
   assign(archivo, 'C:\Users\Dolores\Documents\Facultad\Conceptos de Bases de Datos\Práctica 1\numeros.bin'); // crear un archivo binario
   rewrite(archivo);

   // generar y escribir números aleatorios en el archivo
   Randomize; // Inicializar generador de números aleatorios
   for i := 1 to CANTIDAD_NUMEROS do begin
     numero := Random(100); // Generar número aleatorio entre 0 y 99
     write(archivo, numero); // Escribir número en el archivo
     //analizo el max
     if (max < numero) then
        max := numero;
     //analizo min
     if (min > numero) then
        min := numero;
   end;

    close(archivo); // Cerrar el archivo

    reset(archivo);  // abro archivo ya existente
    while (not EOF(archivo)) do begin
          read(archivo, numero);
          writeln(numero); // imprime listando el contenido en pantalla
    end;
    writeln('La maxima cantidad de votantes es: ', max);
    writeln('La mminima cantidad de votantes es: ', min);

    // Cerrar el archivo
    close(archivo);


end.
