{5. Realizar un programa, con la declaraci�n de tipos correspondientes que permita
crear un archivo de registros no ordenados con informaci�n de especies de flores
originarias de Am�rica. La informaci�n ser� suministrada mediante teclado. De
cada especie se registra: n�mero de especie, altura m�xima, nombre cient�fico,
nombre vulgar, color y altura m�xima que alcanza. La carga del archivo debe
finalizar cuando se reciba como nombre cient�fico: �zzz�.

Adem�s se deber� contar con opciones del programa que posibiliten:
a) Reportar en pantalla la cantidad total de especies y la especie de menor y de
mayor altura a alcanzar.
b) Listar todo el contenido del archivo de a una especie por l�nea.
c) Modificar el nombre cient�fico de la especie flores cargada como: Victoria
amazonia a: Victoria amaz�nica.
d) A�adir una o m�s especies al final del archivo con sus datos obtenidos por
teclado. La carga finaliza al recibir especie �zzz�.
e) Listar todo el contenido del archivo, en un archivo de texto llamado �flores.txt�.
El archivo de texto se tiene que poder reutilizar.
f) �Qu� cambiar�a en la escritura del archivo de texto si no fuera necesario
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
   assign(archivo, 'C:\Users\Dolores\Documents\Facultad\Conceptos de Bases de Datos\Pr�ctica 1\archivoFlores.txt');
   rewrite(archivo); // creo archivo
   cargarArchivo(archivo); // cargo archivo
   close(archivo);

   reset(archivo); // para leer el archivo
   while

end.
