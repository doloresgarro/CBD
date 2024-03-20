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


// --------------- PROCEDIMIENTOS --------------- 

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


{a) Reportar en pantalla la cantidad total de especies y la especie de menor y de
    mayor altura a alcanzar. }
procedure cantidadMaximoMinimo(var max, min:double; var numEspecieMax, numEspecieMin, total: Integer; flor:flores);
begin
     total:= total + 1;
     if (flor.alturaAlcanzable > max) then begin
        max:= flor.alturaAlcanzable;
        numEspecieMax:= flor.numEspecie;
     end;
     if (flor.alturaAlcanzable < min) then begin
        min:= flor.alturaAlcanzable;
        numEspecieMin:= flor.numEspecie;
     end;
end;




// --------------- PROGRAMA PRINCIPAL ---------------
var
   archivo:arch;
   flor:flores;
   min, max: double;
   cantTotal, numEspecieMax, numEspecieMin:Integer;
   archivoTexto:Text;

begin
   assign(archivo, 'C:\Users\Dolores\Documents\Facultad\Conceptos de Bases de Datos\Práctica 1\archivoFlores.txt');
   rewrite(archivo); // creo archivo
   cargarArchivo(archivo); // cargo archivo
   close(archivo);

   reset(archivo); // para leer el archivo

  {a) Reportar en pantalla la cantidad total de especies y la especie de menor y de
    mayor altura a alcanzar.
   b) Listar todo el contenido del archivo de a una especie por línea.
   c) Modificar el nombre científico de la especie flores cargada como: Victoria
   amazonia a: Victoria amazónica.}
   cantTotal:= 0;  min:= 99999; max:= -1;
   while (not EOF(archivo)) do begin
         read(archivo, flor);
         cantidadMaximoMinimo(max, min, numEspecieMax, numEspecieMin, cantTotal, flor);
         // Contenido de una especie por linea
         writeln('Numero de especie: ', flor.numEspecie, ', altura máxima: ', flor.alturaMax, ', nombre cientifico: ', flor.nombreCientifico, ', nombre vulgar: ', flor.nombreVulgar, ', color: ', flor.color, ', altura alcanzable: ', flor.alturaAlcanzable);

         if (flor.nombreCientifico = 'Victoria amazonia') then
            flor.nombreCientifico:= 'Victoria amazónica';
   end;
   writeln('La cantidad total de especies es: ', cantTotal, ', la especie de mayor altura a alcanzar', numEspecieMax, '  la especie de menor altura a alcanzar ', numEspecieMin);

   {d) Añadir una o más especies al final del archivo con sus datos obtenidos por
   teclado. La carga finaliza al recibir especie “zzz”.}
   seek(archivo, Filesize(archivo)-1);
   leerFlor(flor);
   while (flor.numEspecie <> -1) do begin
       writeln('Añadir más especies');
       write(archivo, flor);
       leerFlor(flor);
   end;
   close(archivo);


   {e) Listar todo el contenido del archivo, en un archivo de texto llamado “flores.txt”.
   El archivo de texto se tiene que poder reutilizar. }
   reset(archivo); // abro archivo para lectura
   assign(archivoTexto, 'C:\Users\Dolores\Documents\Facultad\Conceptos de Bases de Datos\Prácticas\Práctica 1\ archTextoEj5.txt');
   rewrite(archivoTexto); // creo el archivo

   while(not EOF(archivo))do begin
       read(archivo, flor);
       writeln(archivoTexto, flor.numEspecie,flor.alturaMax, flor.nombreCientifico, flor.nombreVulgar, flor.color, flor.alturaAlcanzable);
   end;

   {f) para que sea reutilizable se debe tener un string por linea y debe ser LO ULTIMO por lo tanto cambio el while del e) de la siguiente manera
   while(not EOF(archivo))do begin
       read(archivo, flor);
       writeln(archivoTexto, flor.numEspecie,flor.alturaMax;
       writeln(archivoTexto,flor.nombreCientifico);
       writeln(flor.nombreVulgar);
       writeln(flor.alturaAlcanzable,flor.color);
   end; }

   close(archivo);
   close(archivoTexto);

end.
