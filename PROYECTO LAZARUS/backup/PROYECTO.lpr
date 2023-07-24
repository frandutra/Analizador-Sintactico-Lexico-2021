program PROYECTO;

USES crt,estetica,declaraciones,anasin,  Evaluador;
var
  n,r:string;
  raiz:tarbolderivacion;

  estado:testado;
BEGIN
   pantalla1;
   ruta(n,r);
   analizadorsint(r,raiz,s);
   readkey;
   inicializarestado(estado);
   clrscr;
   evalprograma(raiz,estado);
   readkey;
   pantalla2(n,r,s);
   readkey;
END.


