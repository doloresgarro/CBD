{ 4. Una cadena de cines de renombre desea administrar la asistencia del público a las
diferentes películas que se exhiben actualmente.

Para ello cada cine genera semanalmente un archivo indicando: código de película, nombre de la película, género,
director, duración, fecha y cantidad de asistentes a la función.

Se sabe que la cadena tiene 20 cines.

Escriba las declaraciones necesarias y un procedimiento que reciba los
20 archivos y un String indicando la ruta del archivo maestro y genere el archivo
maestro de la semana a partir de los 20 detalles (cada película deberá aparecer una
vez en el maestro con los datos propios de la película y el total de asistentes que tuvo
durante la semana).

Todos los archivos detalles vienen ordenados por código de
película.

Tenga en cuenta que en cada detalle la misma película aparecerá tantas
veces como funciones haya dentro de esa semana.
}
program Ejercicio4;
const
     valorAlto = 9999;
     N = 20;
type
    pelicula = record
      codigo, duracion:integer;
      nombre, genero, director: string[20];
      fecha: string[8];
    end;

    peliculaDetalle = record
          cantAsistentes:integer;
          datosPelicula:pelicula;
    end;

    peliculaMaestro = record
          totalAsistentes: integer;
          datosPelicula: pelicula;
     end;


    detalle = file of peliculaDetalle;
    maestro = file of peliculaMaestro;

    archivos_detalle = array[1..N] of detalle;
    vector_peliculas = array [1..N] of peliculaDetalle;


// -------- PROCEDIMIENTOS --------


procedure leer(var archivo:detalle; var dato:peliculaDetalle);
begin
   if not(EOF(archivo)) then
      read(archivo, dato)
   else
       dato.datosPelicula.codigo:= valorAlto;
end;

procedure minimo (archivosDetalle: archivos_detalle; peliculas:vector_peliculas; min: peliculaDetalle);
var
   pos,i:integer;
begin
     pos:= 1;
     min:= peliculas[pos];

     for i:= 1 to N do begin
         if (min.datosPelicula.codigo > peliculas[i].datosPelicula.codigo) then begin
            min:= peliculas[i];
            pos:= i;
         end;
     end;
     leer(archivosDetalle[pos], peliculas[pos]);

end;

{Escriba las declaraciones necesarias y un procedimiento que reciba los
20 archivos y un String indicando la ruta del archivo maestro y genere el archivo
maestro de la semana a partir de los 20 detalles (cada película deberá aparecer una
vez en el maestro con los datos propios de la película y el total de asistentes que tuvo
durante la semana).}

procedure generarArchivoMaestro(var ruta:string; var archivosDetalle:archivos_detalle);
var
    archMaestro: maestro;
    peliculas:vector_peliculas;
    i, aux:integer;
    min:peliculaDetalle;
    peliculaM:peliculaMaestro;
begin

     assign(archMaestro, ruta);
     rewrite(archMaestro);

     for i:=0 to N do begin
       leer(archivosDetalle[i], peliculas[i]);
     end;

     minimo(archivosDetalle, peliculas, min);
     while(min.datosPelicula.codigo <> valorAlto) do begin
         aux:= min.datosPelicula.codigo;
         peliculaM.datosPelicula:= min.datosPelicula;

         while(aux = min.datosPelicula.codigo) do begin
             peliculaM.totalAsistentes:=  peliculaM.totalAsistentes + min.cantAsistentes;
             minimo(archivosDetalle, peliculas, min);
         end;
         write(archMaestro, peliculaM);
     end;
     close(archMaestro);

end;

var
   ruta:string;
   i:integer;
   detalles:archivos_detalle;
begin

   ruta:= 'C:\Users\Dolores\Documents\Facultad\Conceptos de Bases de Datos\Prácticas\Práctica 2';
   for i:=1 to N do begin
       assign (detalles[i], 'detalle' + i);
       reset(detalles[i]);  // suponiendo que ya existen
   end;

   generarArchivoMaestro(ruta, detalles);

   for i:=1 to N do begin
      close(detalles[i]);
   end;

end.
