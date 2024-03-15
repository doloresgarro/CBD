{7. Realizar un programa con opciones para:
a. Crear un archivo de registros no ordenados con la información
correspondiente a los alumnos de la facultad de ingeniería y cargarlo con
datos obtenidos a partir de un archivo de texto denominado “alumnos.txt”.
Los registros deben contener DNI, legajo, nombre y apellido, dirección, año
que cursa y fecha de nacimiento (longInt).

b. Listar en pantalla toda la información de los alumnos cuyos nombres
comiencen con un carácter proporcionado por el usuario.
c. Listar en un archivo de texto denominado “alumnosAEgresar.txt” todos los
registros del archivo de alumnos que cursen 5º año.
d. Añadir uno o más alumnos al final del archivo con sus datos obtenidos por
teclado.
e. Modificar el año que cursa un alumno dado. Las búsquedas son por legajo
del alumno.}

program Ejercicio7;
uses
    crt;
type
    alumno = record
           DNI:Integer;
           legajo:string[10];
           nomApellido:string[20];
           direccion:Integer;
           anio: Integer;
           materias: string[20];
           nacimiento:longInt;
    end;

    archAlumnos = file of alumno;

// ----------------- PROCEDIMIENTOS ----------------- 

procedure crearArchivo(var archivoTexto: archAlumnos);
var
    a:alumno;
    archivo:archAlumnos;
begin
     assign(archivo, 'archivo.bin');
     rewrite(archivo); // creo archivo binario

     while(not EOF(archivo)) do begin
          read(archivoTexto,  a);
          write(archivo, a);
     end;
     close(archivo);   
end;


{b. Listar en pantalla toda la información de los alumnos cuyos nombres
comiencen con un carácter proporcionado por el usuario.}
procedure listarInfo(var arch: archAlumnos);
var
    a:alumno;
    car:char;
begin
     writeln('Ingrese con que caracter debe comenzar el nombre del alumno:');
     readln(car);
     while(EOF(arch)) do begin
        read(arch,  a);
        if (a.nomApellido[0] = car) then
           write(arch, a);
     end;
end;

{c. Listar en un archivo de texto denominado “alumnosAEgresar.txt” todos los
registros del archivo de alumnos que cursen 5º año.}
procedure listarEnArchivoTexto(var arch:archAlumnos);
var
   nuevo: archAlumnos;
   a:alumno;
begin
   assign(nuevo, 'alumnosAEgresar.txt');
   rewrite(nuevo); // creo archivo
   while (EOF(arch)) do begin
         read(arch,  a);  // leo del archivo
         if (a.anio = 5) then
            // escribo en el archivo
            write(nuevo, a);
   end;
   close(nuevo);

end;

{d. Añadir uno o más alumnos al final del archivo con sus datos obtenidos por
teclado.}
procedure anadir(var arch:archAlumnos);
var
   a:alumno;
begin
     seek(arch, Filesize(arch)-1);
     writeln('Ingresar datos de alumno: ');
     read( a.DNI, a.legajo, a.nomApellido, a.direccion, a.anio, a.materias, a.nacimiento);
     write(arch, a);
end;

{e. Modificar el año que cursa un alumno dado. Las búsquedas son por legajo
del alumno.}
procedure modificarAnio(var arch:archAlumnos);
var
   a:alumno;
   legajo:string[10];
begin
     writeln('Ingresar legajo del alumno a modificar: ');
     readln(legajo);
     while (not EOF(arch)) do begin
         read(arch,  a);
         if (a.legajo = legajo) then begin
            a.anio:= 2;
            seek(arch, Filepos(arch)-1);
            write(arch, a)
          end;
     end;
end;


// ----------------- PROGRAMA PRINCIPAL -----------------
var
    archivoTexto:archAlumnos;
    opcion:Integer;
begin

     writeln('Ingrese opcion 1, 2, 3, 4. (0 para terminar):');
     assign(archivoTexto, 'alumnos.txt');
     reset(archivoTexto); // abro archivo que contiene info
     read(opcion);
     case opcion of
          1: crearArchivo(archivoTexto);
          2: listarInfo(archivoTexto);
          3: listarEnArchivoTexto(archivoTexto);
          4: anadir(archivoTexto);
          5: modificarAnio(archivoTexto);
          else
              writeln('Opción inválida');
     end;
     close(archivoTexto);
end.
