{4. Crear un procedimiento que reciba como parámetro el archivo del punto 2, y
genere un archivo de texto con el contenido del mismo}

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
type
    arch = file of string[20];
   // archTexto = file of string[20];


// ---------------------- procedimientos ----------------------
procedure crearArchivoBin(var archivo:arch); // por que me pide que lo pase por referencia?
var
   archivoDeTexto: Text;
   numero:string[20];
begin
    reset(archivo); // abrir archivo binario
    assign(archivoDeTexto, 'C:\Users\Dolores\Documents\Facultad\Conceptos de Bases de Datos\Práctica 1\archivoDeTexto.txt');
    rewrite(archivoDeTexto); // creo archivo de texto

    while (not EOF(archivo)) do begin
          read(archivo, numero);  // leo numero de archivo binario
          write(archivoDeTexto, numero); // copio numero en archivo de texto
          //writeln(numero); // imprime listando el contenido en pantalla
    end;
    close(archivoDeTexto);
    close(archivo);

end;

var
  archivo:arch;
begin
   assign(archivo, 'numeros.bin');
   crearArchivoBin(archivo);



end.
