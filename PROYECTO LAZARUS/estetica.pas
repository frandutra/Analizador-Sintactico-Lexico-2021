unit estetica;

interface

Uses crt;

Var n,p:string;
    s:boolean;

Procedure pantalla1;
Procedure pantalla2(n:string; r:string; s:boolean);
procedure Mensaje(U,U1:byte;msj:string);
procedure Color(T,F:byte);

procedure marco3;
procedure cargando;

implementation

procedure Color(T,F:byte);
 begin
     Textcolor(T);
     Textbackground(F);
 end;

procedure Mensaje(U,U1:byte;msj:string);
 begin
     gotoxy(U,U1);
     write(msj);
 end;

Procedure pantalla1;
 begin
     color(15,0);
     Mensaje(40,13,'Escriba el nombre del programa:');
     Mensaje(40,16,'Escriba la ruta:');
 end;

Procedure ruta;
 begin
     gotoxy(70,4);
     readln(n);
     gotoxy(70,7);
     readln(p);
 end;

Procedure pantalla2(n:string; r:string; s:boolean);
 begin
     color(white,black);
     Mensaje(40,9,'Programa: ');
     Mensaje(50,9,n);
     Mensaje(40,12,'Ruta: ');
     Mensaje(50,12,r);
     if s=true then
         begin
          clrscr;
          Mensaje(45,19,'Compilo Correctamente')
         end
     else
         begin
          clrscr;
          Mensaje(45,19,'Error al compilar');
         end;

 end;



procedure cargando;

Var
   i,b:byte;
Begin
textcolor(11);
for i:=25 to 26 do                                                {columnas de |}
    begin
    gotoxy(53,i); write('|');
    gotoxy(97,i); write('|');
    end;
for i:= 54 to 96 do                                                  {filas de _}
    begin
    gotoxy(i,24);write('_');
    gotoxy(i,26); Write('_');
    end;
textcolor(white);
gotoxy(55,25); write('Cargando');
for b:=65 to 95 do
           begin;
                gotoxy(b,25);Write('_');
                delay(50);
           end;

end;




procedure marco3;
 Var
   i:byte;
Begin
textcolor(white);
for i:=8 to 20 do                                                {columnas de |}
    begin
    gotoxy(30,i); write('|');
    gotoxy(88,i); write('|');
    end;
for i:=31 to 87 do                                                  {filas de _}
    begin
    gotoxy(i,7);write('_');
    gotoxy(i,20); Write('_');
    end;
gotoxy(35,7);
write('RETAMERO MARCOS, DUTRA FRANCISCO');
 end;


END.

