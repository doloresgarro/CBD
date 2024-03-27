{2. Se necesita contabilizar los CD vendidos por una discográfica.
Para ello se dispone de un archivo con la siguiente información: código de autor, nombre del autor, nombre
disco, género y la cantidad vendida de ese CD.
Realizar un programa que muestre un listado como el que se detalla a continuación.

Dicho listado debe ser mostrado en pantalla y además listado en un archivo de texto.
En el archivo de texto se debe listar nombre del disco, nombre del autor y cantidad vendida.
El archivo origen está ordenado por código de autor, género y nombre disco.}

program Ejercicio2;
const
     FIN = 'zzz';
     valorAlto = '9999';
type
    string20 = string[20];
    datos = record
          codigo_autor:string[5];
          nombre_autor:string20;
          nombre_disco:string20;
          genero:string20;
          cant_vendida:integer; // cantidad vendida de ese cd
    end;

    archivoCDs = file of datos;


// ------------ PROCEDIMIENTOS ------------
procedure crearArchivo(var archivo: archivoCDs);
var
	d: datos;
begin
	writeln('Ingrese el nombre del autor: ');
    readln(d.nombre_autor);
	while(d.nombre_autor <> FIN) do begin
		writeln('Ingrese el nombre del disco: ');
        readln(d.nombre_disco);
		writeln('Ingrese el genero: ');
        readln(d.genero);
		writeln('Ingrese el codigo de autor: ');
        readln(d.codigo_autor);
		writeln('Ingrese la cantidad de copias vendidas: ');
        readln(d.cant_vendida);
		write(archivo, d);
		writeln('Ingrese el nombre del autor ');
        readln(d.nombre_autor);
	end;
	close(archivo);
end;


procedure leer(var archivo: archivoCDs; var dato:datos);
begin
	if (not EOF(archivo)) then
        read(archivo, dato)
	else
     dato.codigo_autor:= valoralto;
end;


// -------------- PROGRAMA PRINCIPAL --------------
var
  archivo: archivoCDs;
  totalVendidos,totalGenero,totalAutor:integer;
  archivoTexto:text;
  d,aux:datos;

begin

     assign(archivo, 'C:\Users\Dolores\Documents\Facultad\Conceptos de Bases de Datos\Prácticas\Práctica 2\archivoDiscografica.dat');
	 rewrite(archivo);
     crearArchivo(archivo);
     close(archivo);

     assign(archivoTexto, 'C:\Users\Dolores\Documents\Facultad\Conceptos de Bases de Datos\Prácticas\Práctica 2\archivoTexto.txt');
     rewrite(archivoTexto);
     close(archivoTexto);

     // se dispone de archivo con la info de datos
     reset(archivo);
     reset(archivoTexto);

     totalVendidos:= 0; // Entre todos los autores


     leer(archivo, d);
     while (d.codigo_autor <> valorAlto) do begin // mientras no se termine el arch
           totalAutor:= 0;
           aux.codigo_autor:= d.codigo_autor;
           writeln('Autor: ', d.codigo_autor); // imprimo en pantalla
           writeln(archivoTexto, 'Autor: ', d.codigo_autor); // copio en arch texto

           while (aux.codigo_autor = d.codigo_autor) do begin
                 writeln('Genero: ', d.genero); // imprimo en pantalla
                 writeln(archivoTexto, 'Genero: ' ,d.codigo_autor); // copio en arch texto
                 totalGenero:= 0;

                 while ((aux.codigo_autor = d.codigo_autor) and (aux.genero = d.genero)) do begin
                        totalGenero:= totalGenero + d.cant_vendida;
                        writeln('Nombre Disco: ', d.nombre_disco); // imprimo en pantalla
                        writeln(archivoTexto, 'Nombre Disco: ', d.nombre_disco); // copio en arch texto

                        leer(archivo, d);
                 end;
                 writeln('Total Genero: ', totalGenero);
                 writeln(archivoTexto, 'Total Genero: ', totalGenero);
                 totalAutor:= totalAutor + totalGenero;
           end;
           totalVendidos:= totalVendidos + totalAutor;
     end;
     totalVendidos:= totalVendidos + totalAutor;
     writeln('TOTAL VENDIDOS: ', totalVendidos); // pantalla
     writeln(archivoTexto, 'TOTAL VENDIDOS: ', totalVendidos); // archivo


    close(archivo);
    close(archivoTexto);

end.
