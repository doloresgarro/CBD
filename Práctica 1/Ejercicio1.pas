{Realizar un programa que permita crear un archivo conteniendo información de
nombres de materiales de construcción, el archivo no es ordenado. Efectúe la
declaración de tipos correspondiente
Luego realice un programa que permita la carga del archivo con datos ingresados por
el usuario. El nombre del archivo debe ser proporcionado por el usuario. La carga
finaliza al procesar el nombre ‘cemento’ que debe incorporarse al archivo.
}

program Ejercicio1;
const
     FIN = 'cemento';
type
    arch = file of string[50];  // declaro tipo de archivo
var
   archivo:arch; // declaro archivo de materiales
   nombreMaterial: string[50];
begin
   assign(archivo, 'C:\Users\Dolores\OneDrive\Documentos\Facultad\Conceptos de Bases de Datos\materialesConstruccion.txt'); // al nombre lógico le asigno el nombre fisico
   rewrite(archivo); // creo el archivo

   // usar repeat until para añadir tambien cemento
   repeat
         writeln('Ingrese un nombre de material: ');
         readln(nombreMaterial);
         write(archivo, nombreMaterial); // escribe en archivo el nombre del materual
   until (nombreMaterial = FIN);

   close(archivo);
end.
