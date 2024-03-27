{. El área de recursos humanos de un ministerio administra el personal del mismo
distribuido en 10 direcciones generales.

Entre otras funciones, recibe periódicamente un archivo detalle de cada una de las
direcciones conteniendo información de las licencias solicitadas por el personal.

- Cada archivo detalle contiene información que indica: código de empleado, la fecha y
la cantidad de días de licencia solicitadas.

- El archivo maestro tiene información de cada empleado: código de empleado, nombre y apellido, fecha de nacimiento,
dirección, cantidad de hijos, teléfono, cantidad de días que le corresponden de
vacaciones en ese periodo.

Tanto el maestro como los detalles están ordenados por
código de empleado.

Escriba el programa principal con la declaración de tipos
necesaria y realice un proceso que reciba los detalles y actualice el archivo
maestro con la información proveniente de los archivos detalles.

Se debe actualizar la cantidad de días que le restan de vacaciones.
Si el empleado tiene menos días de los que solicita deberá informarse en un archivo
de texto indicando: código de empleado, nombre y apellido, cantidad de días que
tiene y cantidad de días que solicita.
}

program Ejercicio1;
const
     valorAlto = '9999';
type

    regDetalle = record
            codigo_empleado:string[5];
            fecha:string[10]; // fecha de días de licencia solicitada.
            dias_licencia:integer; // cantidad de dias de licencia solicitada
    end;

    regMaestro = record
            codigo_empleado:string[5];
            nombreApellido:string[20];
            fechaNacimiento:string[10];
            direccion:string[10];
            cant_hijos:integer;
            telefono:integer;
            dias_vacaciones:integer;
    end;

    regArchivoTexto = record
            codigo_empleado:string[5];
            nombreApellido:string[20];
            dias_vacaciones:integer; // cantidad de días que tiene
            dias_licencia:integer; // cantidad de dias de licencia solicitada
    end;

    archDetalle = file of regDetalle;
    archMaestro = file of regMaestro;
    archTexto = file of regArchivoTexto;

// ---------------- PROCEDIMIENTOS ----------------

// Procedimiento que lee del archivo detalle un dato del tamaño del registro detalle
procedure leer(var archivo:archDetalle; var dato:regDetalle);
begin
   if (not EOF(archivo)) then
      read(archivo, dato)
   else
       dato.codigo_empleado:= valorAlto; // cuando se termina el archivo detalle
end;

{ Procedimiento que devuelve en un parámetro por referencia el registro con código
 minimo para copiar info correspodiente en el archivo maestro }
procedure minimo(var r1, r2, r3: regDetalle; var min:regDetalle; var d1, d2, d3:archDetalle);
begin
     // ordenados por codigo de empleado
     if (r1.codigo_empleado <= r2.codigo_empleado) and (r1.codigo_empleado <= r3.codigo_empleado) then begin
        min:= r1;
        leer(d1, r1); //
     end
     else if (r2.codigo_empleado <= r3.codigo_empleado) then begin
        min:= r2;
        leer(d2, r2);
     end
     else begin
          min:= r3;
          leer(d3, r3);
     end;
end;

procedure copiaMaestroDetalle(var maestro:archMaestro; var arch_d1, arch_d2, arch_d3: archDetalle; var archivoTexto: archTexto);
var
  m: regMaestro;
  d1, d2, d3, min: regDetalle;
  aux:string[5];
  e:regArchivoTexto;
begin
    while(not EOF(maestro)) do begin
               read(maestro, m); // lee del arch maestro un registro del tamaño regMaestro
               leer(arch_d1, d1);// lee del arch detalle un registro del tamaño regDetalle
               leer(arch_d2, d2);
               leer(arch_d3, d3);
     end;

     minimo(d1, d2, d3, min,arch_d1, arch_d2, arch_d3); // obtiene el minimo

     while (min.codigo_empleado <> valorAlto) do begin
           while (d1.codigo_empleado <> min.codigo_empleado) do // busco el codigo min en el arch maestro
                 read(maestro, m);

           aux:= min.codigo_empleado;
           while(aux = min.codigo_empleado) do begin
             if (m.dias_vacaciones < min.dias_licencia) then begin // si los dias de lic que solicito son menores a los que tiene
                 e.codigo_empleado:= m.codigo_empleado;
                 e.nombreApellido:= m.nombreApellido;
                 e.dias_vacaciones:=  m.dias_vacaciones;
                 e.dias_licencia:= min.dias_licencia;
                 write(archivoTexto, e.codigo_empleado);
                 write(archivoTexto, e.dias_licencia, e.dias_vacaciones, e.nombreApellido); // guardo en archivo de texto
              end;
              m.dias_vacaciones:= m.dias_vacaciones - min.dias_licencia; // a los dias que tenia le resto los que pidió
           end;
           seek(maestro, filepos(maestro)-1);
           write(maestro, m); // actualiza el arch maestro
     end;
end;

var
   maestro:archMaestro;
   arch_d1, arch_d2, arch_d3:archDetalle;
   archivoTexto: archTexto;

// ---------------- PROGRAMA PRINCIPAL ----------------
begin
     // asocio archivos --> deberian ser 10
     assign(maestro, 'maestro.dat');
     assign(arch_d1, 'detalle1.dat');
     assign(arch_d2, 'detalle2.dat');
     assign(arch_d3, 'detalle3.dat');
     // creo archivos
     rewrite(maestro);
     rewrite(arch_d1);
     rewrite(arch_d2);
     rewrite(arch_d3);

      // creo archivo de texto en donde guardo la info de los empleados que solicitan mas días de los que corresponden
     assign(archivoTexto, 'solicitaMasDias.txt');
     rewrite(archivoTexto);

     copiaMaestroDetalle(maestro, arch_d1, arch_d2, arch_d3, archivoTexto);

     close(maestro); // cierro archivo maestro
     close(arch_d1); // cierro archivos detalle
     close(arch_d2);
     close(arch_d3);
     close(archivoTexto); // cierro archivo de texto
end.
