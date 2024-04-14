{2. Se dispone de un archivo que contiene informaci�n de autos en alquiler de una rentadora. Se
sabe que el archivo utiliza la t�cnica de lista invertida para aprovechamiento de espacio. Es
decir las bajas se realizan apilando registros borrados y las altas reutilizando registros
borrados. El registro en la posici�n 0 del archivo se usa como cabecera de la pila de registros
borrados.

Nota: El valor �0� en el campo descripci�n significa que no existen registros borrados, y �N�
indica que el pr�ximo registro a reutilizar es el N, siendo �ste un n�mero relativo de registro
v�lido.
Se solicita implementar los siguientes m�dulos:

}

program Ejercicio2;
const
     valorAlto = 9999;
type

    tVehiculo= Record
               codigoVehiculo:integer;
               patente: String;
               motor:String;
               cantidadPuertas: integer;
               precio:real;
               descripcion:String
    end;
    tArchivo = File of tVehiculo


procedure leer(var archivo:tArchivo; var dato:tVehiculo);
begin
    if (not EOF(archivo)) then
       read(archivo, dato)
    else
        dato.codigoVehiculo:= valorAlto;
end;


{Abre el archivo y agrega un veh�culo para alquiler, el mismo se recibe como par�metro y
debe utilizar la pol�tica descripta anteriormente para recuperaci�n de espacio}
Procedure agregar (var arch: tArchivo; vehiculo: tVehiculo);
var

   v,reg: tVehiculo;
   cod, posLibre:integer;
begin
     reset(arch);                  // abre archivo
     read(arch, v);                // leo cabecera
     Val(v.descripcion, posLibre, cod); //  se utiliza para convertir una cadena de caracteres en un n�mero entero

     if (posLibre = -1) then
        seek(arch, filesize(arch)) // si no hay pos disponible lo coloca al final
     else begin
         seek(arch, posLibre);     // me posiciono en la pos libre
         read(arch, reg);          // leo del archivo el registro

         seek(arch, 0);            // actualizo cabecera
         write(arch, v);
         seek(arch, posLibre);
     end;

     write(arch, v);        // escribo en el reg libre o al final del arch

     close(arch);

end;



{Abre el archivo y elimina el veh�culo que posea el c�digo recibido como par�metro
manteniendo la pol�tica descripta anteriormente}
Procedure eliminar (var arch: tArchivo; codigoVehiculo: integer);
var
   v, vLibre: tVehiculo;
   posLibre: integer;
Begin
   reset(arch);
   read(arch, vLibre); // leo cabecera para copiar en la pos que este libre

   read(arch, v);
   while (v.codigoVehiculo <> valorAlto) and (v.codigoVehiculo<> codigoVehiculo) do begin
        read(arch, v);
   end;

   if (v.codigoVehiculo <> valorAlto) then begin
      posLibre:= filepos(arch) - 1;
      seek(arch, posLibre);
      write(arch, vLibre);            // piso el valor que tiene el registro a reemplazar
      str(posLibre, vLibre);          // paso de int a string

      seek(arch, 0);
      write(arch, vLibre);
   end
   else
       writeln('Veh�culo no encontrado');

   close(arch);
End;


