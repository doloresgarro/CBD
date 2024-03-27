{ 4. Una cadena de cines de renombre desea administrar la asistencia del p�blico a las
diferentes pel�culas que se exhiben actualmente.

Para ello cada cine genera semanalmente un archivo indicando: c�digo de pel�cula, nombre de la pel�cula, g�nero,
director, duraci�n, fecha y cantidad de asistentes a la funci�n.

Se sabe que la cadena tiene 20 cines.

Escriba las declaraciones necesarias y un procedimiento que reciba los
20 archivos y un String indicando la ruta del archivo maestro y genere el archivo
maestro de la semana a partir de los 20 detalles (cada pel�cula deber� aparecer una
vez en el maestro con los datos propios de la pel�cula y el total de asistentes que tuvo
durante la semana).

Todos los archivos detalles vienen ordenados por c�digo de
pel�cula.

Tenga en cuenta que en cada detalle la misma pel�cula aparecer� tantas
veces como funciones haya dentro de esa semana.
}
program Ejercicio4;
const
     valorAlto = '9999';
     N = 3; // 20
type
    pelicula = record
      codigo, duracion, cantAsistentes:integer;
      nombre, g�nero, director: string[20];
      fecha: string[8];
    end;
    datos = file of pelicula;
    cine = array [1..N] of datos;

var

// -------- PROCEDIMIENTOS --------


procedure leer(var archivo:archLocales; var dato:datosVentas);
begin
   if not(EOF(archivo)) then
      read(archivo, dato)
   else
       dato.codigo_calzado:= valorAlto;
end;

function devuelveMin(v: vectorLocales): integer;
var
   i, valorMin, indiceMin: integer;
begin
	valorMin:= v[1].codigo_calzado;
	indiceMin:= 1;

	for i:=1 to N do begin
		if (v[i].codigo_calzado < valorMin) then begin
			valorMin:=v[i].codigo_calzado;
			indiceMin:= i;
		end;
	end;
	devuelveMin:= indiceMin;
end;

procedure minimo(var r: vectorLocales; var min: datosVentas; var det:vectorLocales);
var
   i: integer;
begin
	i:= devuelveMin(r);
	min:= r[i];
	leer(det[i], regd[i]);
end;


var
   maestro: archMaestro;
   detalles: vectorLocales; // arreglo de archivos detalle
   i:integer;
begin
   // creo archivo maestro y detalles para probar el programa
   assign(maestro, 'maestro.dat');
   rewrite(maestro);
   close(maestro);

   reset(maestro);

   for i:=0 to N do begin
      reset(detalles[i]);  // suponiendo que ya existen
   end;







   close(maestro);
   for i:=0 to N do begin
      close(detalles[i]);
   end;

end.
