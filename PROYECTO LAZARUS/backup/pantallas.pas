unit pantallas;

interface

Uses crt;

Var n,p:string;
    s:boolean;

Procedure pantalla1;
Procedure pantalla2(n:string; r:string; s:boolean);
Procedure ruta;
procedure Mensaje(U,U1:byte;msj:string);
procedure Color(T,F:byte);

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
     clrscr;
     color(15,0);
     Mensaje(1,4,'Escriba el nombre del programa:');
     Mensaje(1,7,'Escriba la ruta:');
 end;

Procedure ruta;
 begin
     gotoxy(33,4);
     readln(n);
     gotoxy(18,7);
     readln(p);
 end;

Procedure pantalla2(n:string; r:string; s:boolean);
 begin
     clrscr;
     color(blue,black);
     Mensaje(1,4,'Programa: ');
     Mensaje(12,4,n);
     Mensaje(1,5,'ruta: ');
     Mensaje(7,5,r);
     if s=true then
         Mensaje(1,7,'Compilo Correctamente')
     else
         Mensaje(1,7,'Error al compilar');
 end;

END.

