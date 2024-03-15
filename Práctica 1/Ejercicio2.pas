{2. Desarrollar un programa que permita la apertura de un archivo de n�meros enteros
no ordenados. La informaci�n del archivo corresponde a la cantidad de votantes
de cada ciudad de la provincia de buenos aires en una elecci�n presidencial.
Recorriendo el archivo una �nica vez, informe por pantalla la cantidad m�nima y
m�xima de votantes. Adem�s durante el recorrido, el programa deber� listar el
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
   assign(archivo, 'C:\Users\Dolores\Documents\Facultad\Conceptos de Bases de Datos\Pr�ctica 1\numeros.bin'); // crear un archivo binario
   rewrite(archivo);

   // generar y escribir n�meros aleatorios en el archivo
   Randomize; // Inicializar generador de n�meros aleatorios
   for i := 1 to CANTIDAD_NUMEROS do begin
     numero := Random(100); // Generar n�mero aleatorio entre 0 y 99
     write(archivo, numero); // Escribir n�mero en el archivo
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
