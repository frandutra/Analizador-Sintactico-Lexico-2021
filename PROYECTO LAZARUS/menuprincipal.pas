unit menuprincipal;

{$mode objfpc}{$H+}

interface
USES crt,estetica,declaraciones,anasin,  Evaluador;
var
  n,r:string;
  raiz:tarbolderivacion;
  estado:testado;
  procedure  menu;

implementation
procedure menu;
BEGIN

  cargando;
  clrscr;
  marco3;
  pantalla1;
  ruta(n,r);
  clrscr;
   analizadorsint(r,raiz,s);
   readkey;
   inicializarestado(estado);
   clrscr;
   evalprograma(raiz,estado);
   readkey;
   marco3;
   pantalla2(n,r,s);
   readkey;
end;

end.
