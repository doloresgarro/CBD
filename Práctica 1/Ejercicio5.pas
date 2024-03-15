{5. Realizar un programa, con la declaración de tipos correspondientes que permita
crear un archivo de registros no ordenados con información de especies de flores
originarias de América. La información será suministrada mediante teclado. De
cada especie se registra: número de especie, altura máxima, nombre científico,
nombre vulgar, color y altura máxima que alcanza. La carga del archivo debe
finalizar cuando se reciba como nombre científico: ’zzz’.

Además se deberá contar con opciones del programa que posibiliten:
a) Reportar en pantalla la cantidad total de especies y la especie de menor y de
mayor altura a alcanzar.
b) Listar todo el contenido del archivo de a una especie por línea.
c) Modificar el nombre científico de la especie flores cargada como: Victoria
amazonia a: Victoria amazónica.
d) Añadir una o más especies al final del archivo con sus datos obtenidos por
teclado. La carga finaliza al recibir especie “zzz”.
e) Listar todo el contenido del archivo, en un archivo de texto llamado “flores.txt”.
El archivo de texto se tiene que poder reutilizar.
f) ¿Qué cambiaría en la escritura del archivo de texto si no fuera necesario
utilizarlo?
}

program Ejercicio5;
uses
    sysutils;
const
     FIN = 'zzz';
type
    flores = record
           numEspecie: Integer;
           alturaMax: double;
           nombreCientifico: string[20];
           nombreVulgar: string[20];
           color: string[20];
           alturaAlcanzable: double;
    end;

   arch = file of flores;

procedure leerFlor(var f: flores);
begin
    writeln('Ingrese nombre cientifico: ');
    readln(f.nombreCientifico);
    if(f.nombreCientifico <> FIN) then begin
         writeln('Ingrese numero de especie: ');
         readln(f.numEspecie);
         writeln('Ingrese altura maxima: ');
         readln(f.alturaMax);
         writeln('Ingrese nombre vulgar: ');
         readln(f.nombreVulgar);
         writeln('Ingrese color: ');
         readln(f.color);
         writeln('Ingrese altura maxima alcanzable: ');
         readln(f.alturaAlcanzable);

         writeln('Ingrese nombre cientifico: ');
         readln(f.nombreCientifico);
    end;
end;

procedure cargarArchivo(var archivo:arch);
var
    f:flores;
begin
     // aca deberia volver a abrir el archivo??
     leerFlor(f);
     while (f.nombreCientifico <> FIN) do begin
        write(archivo, f);
        leerFlor(f);
     end
end;

var
   archivo:arch;
begin
   assign(archivo, 'C:\Users\Dolores\Documents\Facultad\Conceptos de Bases de Datos\Práctica 1\archivoFlores.txt');
   rewrite(archivo); // creo archivo
   cargarArchivo(archivo); // cargo archivo
   close(archivo);

   reset(archivo); // para leer el archivo
   while

end.
