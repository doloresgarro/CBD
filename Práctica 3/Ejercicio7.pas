{7. Se dispone de un archivo que contiene informaci�n de empleados de la facultad. Se sabe que el
archivo utiliza la t�cnica de lista invertida para aprovechamiento de espacio. Es decir las bajas se
realizan apilando registros borrados y las altas reutilizando registros borrados. El registro en la
posici�n 0 del archivo se usa como cabecera de la pila de registros borrados.

tArchivo = File of persona;
Nota: El valor 0 en el campo DNI significa que no existen registros borrados, y -N indica que el
pr�ximo registro a reutilizar es el N, siendo �ste un n�mero relativo de registro v�lido.
Se solicita implementar los siguientes m�dulos:}

program Ejercicio7;
const
   FIN = -1;
type
    persona = record
             DNI:integer;
             nombre: String;
             apellido:String;
             sueldo: real;
    end;

    tArchivo = file of persona;

{Crear el Archivo Maestro con un archivo de texto que se recibe como
par�metro. Asumir que en el programa principal s�lo est� hecho el
assign de los archivos. Tenga en cuenta la restricci�n de lectura de
los campos en los archivos de texto}
procedure crear(var arch: tArchivo; var info:text);
var
   reg: persona;
begin
     rewrite(arch);        // maestro
     reset(info);

     while (not EOF(info)) do begin
           readln(reg.DNI);
           readln(reg.nombre);
           readln(reg.apellido);
           readln(reg.sueldo);
           write(arch, reg);
     end;
     close(arch);
     close(info);
end;

{Abre el archivo y agrega una persona.
La persona se recibe como par�metro y debe utilizar la pol�tica
descripta anteriormente para recuperaci�n de espacio}
procedure agregar (var arch: tArchivo; p: persona);
var
   sLibre: persona;
   nLibre:integer;
   cod:integer;
begin
     reset(arch);
     read(arch, sLibre); // leo cabecera
     val(sLibre, nLibre, cod);     // ??????? el cod no lo uso
     if (nLibre = 0) then
        seek(arch, filesize(arch)) // si no hay espacio libre lo coloca al final
     else begin
        seek(arch, nLibre);        // pos libre
        read(arch, sLibre);        // lee lo que hay en esa pos
        seek(arch, 0);             // se posiciona en 0
        write(arch, sLibre);       // actualiza cabecera
        seek(arch, nLibre);        // se posiciona donde habia lugar p/ luego copiar la persona recibida
     end;

     write(arch, p);               // escribe en el archivo en la pos que habia lugar o sino al final
     close(arch);
end;



{Abre el archivo y elimina la persona que tiene el DNI que se recibe
como par�metro manteniendo la pol�tica descripta anteriormente.
La persona puede no existir}
Procedure eliminar (var arch: tArchivo; DNI: integer);
var
   sLibre, reg: persona;
   nLibre:integer;
begin
   reset(arch);
   read(arch, sLibre);                  // leo cabecera
   while (DNI <> FIN) and (not EOF(arch)) do begin // mientras no encuentre el dni y no termine el arch
         read(arch, reg);
   end;

   if (DNI = FIN) then begin
      nLibre:= filepos(arch) - 1;       // pos act
      seek(arch, nLibre);
      write(arch, sLibre);              // grabo cont en cabecera
      Str(nLibre, sLibre);              // convierto de int a string
      seek(arch, 0);                    // pos cabecera
      write(arch, sLibre);              // actualizo cabecera
   end
   else writeln('No se encontr� el DNI');

   close(arch);
end;
