program EjercicioAdicional;
const
     nro_detalle = 500;
     valorAlto = 9999;

type
    detalle = record
            localidad:integer;
            provincia:integer;
            cod_loc:integer;
            cod_prov: integer;
    end;

    maestro = record
            prov:string[50];
            cod_prov, validos, blancos, anulados:integer;
    end;

    det = file of detalle;
    mae = file of maestro;

    detR = array [1..nro_detalle] of detalle;   // vector de archivos detalle
    detA = array [1..nro_detalle] of detalle;

procedure leer(var archDetalle:det; var d:detalle);
begin
     if (not(EOF(archDetalle))) then
        read(archDetalle, d)
     else
         d.cod_prov:= valorAlto;

end;


//  minimo(registrosD, archivosD, min);
procedure minimo(var registrosD: detR; var archivosD:detA; var min:detalle);
var
   i, posMin: integer;
begin
     posMin:= 1;
     min:= archivosD[posMin];
     for i:= 2 to nro_detalle do begin
         if (min.cod_prov > archivosD[i].cod_prov) then
            min:= archivosD[posMin];
            posMin:= i;
         end;
     end;
     //chequear la siguiente instrucción
     leer(archivosD[posMin], detR[posMin]); // para el proximo minimo
end;


var
   m:mae; // archivo maestro
   regM: maestro;
   min: detalle;
   aux:integer;
   archivosD:detA; // archivo detalle
   registrosD: detR;
   votos: Text;
   totalb, totalV, totalA:integer;
   cantB, cantV, cantA:integer;

begin

     // asigno y abro arch maestro
     assign(m, 'maestro.txt');
     reset(m);

     // asigno y abro archs detalle
     for i:= 0 to nro_detalle do begin
         assign(archivosD[i], 'detalle' + i);
         reset(archivosD[i]);
         leer(archivos[i], registroD[i]);
     end;

     // arch de texto
     assign(votos, 'cantidadvotos.txt');
     rewrite(votos); // lo creo

     minimo(registrosD, archivosD, min);
     if (not(EOF(maestro)) then
        read(maestro, regM);

     totalB:= 0;
     totalV:= 0;
     totalA:= 0;
     while(min.cod <> valorAlto) do begin

            while(regM.provincia <> min.cod_prov) do begin
                read(maestro, regM);
            end;

            aux:= min.cod_prov;
            while (aux = min.cod_prov) do begin
                  regM.validos:= regM.validos + min.validos;
                  regM.anulados:= regM.anulados + min.anulados;
                  regM.blancos:= regM.blancos + min.blanco;
            end;
            totalB:= totalB + min.blancos;
            totalA:= totalA + min.blancos;
            totalV:= totalV + min.blancos;
            minimo(registrosD, archivosD, min);

            // se posiciona en ult pos del maestro
            seek(m, filepos(M)-1);
            write(m, regM);

     end;

     // Copio información en archivo de texto
     writeln(votos,'Cantidad de archivos detalle procesados: ', nro_detalle);
     writeln(votos, 'Total de votos: ', totalV + totalA + totalB);


     close(maestro);
     close(votos);
     for i:= 1 to nro_detalle do
         close(archivosD[i]);

end.
