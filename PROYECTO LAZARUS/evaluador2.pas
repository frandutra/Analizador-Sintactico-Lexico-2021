unit evaluador2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,declaraciones;

const
  maxlistareal=100;
  maxestado=100;

type
  tpunterolista = ^tlistareal;

  tlistareal = record
    elementos : array [1..maxlistareal] of real;
    cant:integer;
  end;

  telementoestado=record
    lexemaid:string;
    tipo:simbolos;
    valorreal:real;
    valorlista:tpunterolista;
  end;

  testado=record
   elementos : array [1..maxestado] of telementoestado;
   cant:integer;
  end;

//para tpunterolista
procedure inicializarlista(var punt:tpunterolista); //listo
procedure agregar(var l:tpunterolista; var elemento:real);//listo
procedure eliminar(var l:tpunterolista; var posicion:real); //REVISAR
procedure reemplazar(var l:tpunterolista; var posicion:real; var elemento:real);
function cantidad(var l:tpunterolista):integer;          //listo
function elemento(var l:tpunterolista;var posicion:real):real; //listo

//para testado
procedure inicializarestado(var e:testado);
procedure agregarvariable(var e:testado; var id:string; tipo:simbolos);
procedure asignarvalor(var e:testado; var id:string; var valor:real);
procedure asignarlista(var e:testado;var id:string; var l:tpunterolista);
function obtenervalor(var e:testado;var id:string):real;
function obtenerlista(var e:testado;var id:string):tpunterolista;

//para gramatica
Procedure evalPrograma(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evalvariables(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evalbloque(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evaltipo(var raiz:tarbolderivacion; var estado:tEstado; var tipo:simbolos);
Procedure evalsentencia(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evalR(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evalsent(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evalasig(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evalA(var raiz:tarbolderivacion;var estado:testado; var lexema:string);
Procedure evalconstLista(var raiz:tarbolderivacion; var estado:tEstado;var lista:tpunterolista);
Procedure evalH(var raiz:tarbolderivacion; var estado:tEstado;var lista:tpunterolista);
Procedure evalelementos(var raiz:tarbolderivacion; var estado:tEstado;var lista:tpunterolista);
Procedure evalQ(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evalexpAritm(var raiz:tarbolderivacion; var estado:tEstado; var valor:real);
Procedure evalS(var raiz:tarbolderivacion; var estado:tEstado;var operando1:real;var valor:real);
Procedure evalT(var raiz:tarbolderivacion; var estado:tEstado;var operando1:real);
Procedure evalZ(var raiz:tarbolderivacion; var estado:tEstado;var operando1:real;var valor:real);
Procedure evalD(var raiz:tarbolderivacion; var estado:tEstado;var operando1:real);
Procedure evalY(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evalval(var raiz:tarbolderivacion; var estado:tEstado;var valor:real);
Procedure evalcondicional(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evaldisyuncion(var raiz:tarbolderivacion; var estado:tEstado;var valordecondicion:boolean);
Procedure evalP(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evalconjuncion(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evalL(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evalnegacion(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evalcond(var raiz:tarbolderivacion; var estado:tEstado;var valor:boolean);
Procedure evaloprel(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evalE(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evalpara(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evalmientras(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evalleer(var raiz:tarbolderivacion; var estado:tEstado);
Procedure evalescribir(var raiz:tarbolderivacion; var estado:tEstado);
//Procedure eval(var raiz:tarbolderivacion; var estado:tEstado);



implementation

PROCEDURE inicializarlista (VAR L:TPUNTEROLISTA);               //LISTO
  begin
    L^.cant:=0;
  end;
procedure agregar(var l:tpunterolista; var elemento:real);         //LISTO
var
   cant:word;
 begin
   L^.cant:=L^.cant+1;
   L^.elementos[L^.cant]:=elemento;
   end;
procedure eliminar(var l:tpunterolista; var posicion:real);          //LISTO
var
  i:integer;
begin
  for i:=trunc(posicion) to L^.cant-1  do
  begin
       L^.elementos[i]:=L^.elementos[i+1];
  end;
  L^.cant:=L^.cant-1;
end;
procedure reemplazar(var l:tpunterolista; var posicion:real; var elemento:real);          //LISTO
begin
  L^.elementos[trunc(posicion)]:=elemento;
  end;
function cantidad(var l:tpunterolista):integer;    //LISTO
begin
cantidad:=l^.cant;
end;
function elemento(var l:tpunterolista;var posicion:real):real;          //LISTO
begin
elemento:=l^.elementos[trunc(posicion)];
end;
procedure inicializarestado(var e:testado);      //LISTO
begin
e.cant:=0;
end;
procedure agregarvariable(var e:testado; var id:string; tipo:simbolos);  //LISTO

begin
  E.cant:= E.cant+1;
  E.elementos[E.cant].lexemaid:=id;
  E.elementos[E.cant].tipo:=tipo;
  E.elementos[E.cant].valorReal:=0;
  E.elementos[E.cant].valorLista:=nil;
  if  tipo=tlistas then
      begin
          new(E.elementos[E.cant].valorLista);
          InicializarLista(E.elementos[E.cant].valorLista);
      end;

  end;

procedure asignarvalor(var e:testado; var id:string; var valor:real);         //LISTO
var
i:integer;
begin
    For i:=1 to E.cant do
    begin
             if upcase(E.elementos[i].lexemaId)=upcase(id) then
               E.elementos[i].valorReal:=valor;
    end;
  end;
procedure asignarlista(var e:testado;var id:string; var l:tpunterolista);      //LISTO
var
i:integer;
begin
    For i:=1 to E.cant do
    begin
             if upcase(E.elementos[i].lexemaId)=upcase(id) then
               E.elementos[i].valorLista:=l;
    end;
  end;
function obtenervalor(var e:testado;var id:string):real;                //LISTO
var
i:integer;
begin
  obtenerValor:=0;
    For i:=1 to E.cant do
    begin
             if upcase(E.elementos[i].lexemaId)=upcase(id) then
                obtenerValor:=E.elementos[i].valorReal;
    end;
  end;
function obtenerlista(var e:testado;var id:string):tpunterolista;        //LISTO
var
i:integer;
begin
  obtenerLista:=nil;
    For i:=1 to E.cant do
    begin
             if upcase(E.elementos[i].lexemaId)=upcase(id) then
                obtenerLista:=E.elementos[i].valorLista;
    end;
  end;

//Programa → variables bloque
Procedure evalPrograma(var raiz:tarbolderivacion; var estado:tEstado);
  begin
          evalvariables(raiz^.hijos[1],estado);
	  evalBloque(raiz^.hijos[2],estado);
  end;
//variables → id tipo variables | epsilon
Procedure evalvariables(var raiz:tarbolderivacion; var estado:tEstado);
var
  resultado:simbolos;
  tipo:simbolos;
  begin
       if raiz^.cant > 0 then
          begin
            evaltipo(raiz^.hijos[2],estado,tipo);
            AgregarVariable(estado, raiz^.hijos[1]^.lexema , tipo);
            evalvariables(raiz^.hijos[3],estado);
          end;
   end;
//bloque → begin sentencia end
Procedure evalbloque(var raiz:tarbolderivacion; var estado:tEstado);
begin
         evalsentencia(raiz^.hijos[2],estado);
end;
//tipo → lista | real
Procedure evaltipo(var raiz:tarbolderivacion; var estado:tEstado; var  tipo:simbolos);
begin
if raiz^.hijos[1]^.simbolo = tlistas then
   tipo:=tlistas
   else
   tipo:=treal;
end;

//sentencia → sentR
Procedure evalsentencia(var raiz:tarbolderivacion; var estado:tEstado);

begin
        evalSent(raiz^.hijos[1],estado);
	evalR(raiz^.hijos[2],estado);
end;
//R → sentR | epsilon
Procedure evalR(var raiz:tarbolderivacion; var estado:tEstado);
begin
  If raiz^.cant>0 then
        begin
	evalSent(raiz^.hijos[1],estado);
        evalR(raiz^.hijos[2],estado);
        end;
 end;
//sent → asig; | condicional; | para; | mientras; | leer; | escribir; | agregar(id, expAritm); | eliminar(id, expAritm); | reemplazar(id, expAritm, expAritm);
Procedure evalSent(var raiz:tarbolderivacion; var estado:tEstado);
      var
        valor:real;
        lexema:string;
        lista:tPunteroLista;
        posicion:real;

        result:boolean;
begin

  case raiz^.hijos[1]^.simbolo of
       vasig:evalAsig(raiz^.hijos[1],estado);

       vcondicional: evalcondicional(raiz^.hijos[1],estado);

       vpara:evalpara(raiz^.hijos[1],estado);

       vmientras:evalmientras(raiz^.hijos[1],estado);

       vleer:evalleer(raiz^.hijos[1],estado);

       vescribir:evalescribir(raiz^.hijos[1],estado);

       tagregar: begin
	        evalexpAritm(raiz^.hijos[5],estado,valor);
                lista:=obtenerLista(estado,lexema);
	        agregar(lista,valor);
           end;
       teliminar:begin
               evalexpAritm(raiz^.hijos[5],estado,valor);
	       lista:=obtenerlista(estado,raiz^.hijos[3]^.lexema);
	       eliminar(lista,posicion);
           end;
       treemplazar:begin
		evalexpAritm(raiz^.hijos[5],estado,posicion);
		lista:=obtenerlista(estado,raiz^.hijos[3]^.lexema);
                evalexpAritm(raiz^.hijos[7],estado,valor);
                reemplazar(lista,posicion,valor);
           end;
       end;

  end;
//asig → id opAsig A
Procedure evalAsig(var raiz:tarbolderivacion;var estado:tEstado);
begin
  evalA(raiz^.hijos[3],estado,raiz^.hijos[1]^.lexema);
end;
//A → expAritm | constLISTA
Procedure evalA(var raiz:tarbolderivacion; var estado:tEstado;var lexema:string);
var
  Lista:TpunteroLista;
  valor:real;
begin
	  if raiz^.hijos[1]^.simbolo=vexpAritm    then
                        begin
                        evalexpAritm(raiz^.hijos[1],estado,valor);
			asignarvalor(estado,lexema,valor);
                        end
                        else
                        begin
			evalconstLista(raiz^.hijos[1],estado,lista);
			asignarlista(estado,lexema,lista);
                        end;
 end;

//constLISTA → [H]
Procedure evalconstLista(var raiz:tarbolderivacion; var estado:tEstado;var lista:tpunterolista);
begin
                new(lista);
		inicializarlista(lista);
		evalH(raiz^.hijos[2],estado, lista) ;
end;
//H → elementos | epsilon
Procedure evalH(var raiz:tarbolderivacion; var estado:tEstado;var lista:tpunterolista);
begin
		if raiz^.cant > 0  then
			evalelementos(raiz^.hijos[1],estado,lista)
  end;
//elementos → expAritmQ
Procedure evalelementos(var raiz:tarbolderivacion; var estado:tEstado;var lista:tpunterolista);
var
  valor:real;
begin
evalElementos(raiz,estado,lista);
		evalexpAritm(raiz^.hijos[1],estado,valor);
		agregar(lista,valor);
        end;
//Q → ,elementos | epsilon
Procedure evalQ(var raiz:tarbolderivacion; var estado:tEstado);
var
  lista:tpunterolista;
begin
                if raiz^.cant > 0   then
                evalelementos(raiz^.hijos[2],estado,lista)
end;

//expAritm →  TS
Procedure evalexpAritm(var raiz:tarbolderivacion; var estado:tEstado;var valor:real);
var
operando1:real;

begin
evalT(raiz^.hijos[1],estado,operando1);
evalS(raiz^.hijos[2],estado,operando1,valor);

end;

//S → +TS | -TS | epsilon
Procedure evalS(var raiz:tarbolderivacion; var estado:tEstado;var operando1:real;var valor:real);
var
  operando2:real;

  aux:real;
begin
         if raiz^.cant = 0      then
			valor:=operando1
		else
			if raiz^.hijos[1]^.simbolo = tmas then
                           begin
				evalT(raiz^.hijos[2],estado,operando2);
				aux:=operando1 + operando2;
				evalS(raiz^.hijos[3],estado,aux, valor);
                           end
                        else
                        begin
				evalT(raiz^.hijos[2],estado,operando2);
				aux:=operando1 - operando2;
				evalS(raiz^.hijos[3],estado,aux, valor);
                        end;

end;
//T → DZ
Procedure evalT(var raiz:tarbolderivacion; var estado:tEstado;var operando1:real);
var
   valor:real;
begin
  evalD(raiz^.hijos[1],estado,operando1);
  evalZ(raiz^.hijos[2],estado,operando1,valor);
end;
//Z → *DZ | /DZ | epsilon
Procedure evalZ(var raiz:tarbolderivacion; var estado:tEstado;var operando1:real;var valor:real);
var
   operando2,aux:real;
begin
        if raiz^.cant = 0       then
			valor:=operando1
		else
			if raiz^.hijos[1]^.simbolo = tmultiplicar then
                           begin
				evalD(raiz^.hijos[2],estado,operando2);
				aux:=operando1 * operando2;
				evalZ(raiz^.hijos[3],estado,aux, valor);
                                end
			else
                        begin
				evalD(raiz^.hijos[2],estado,operando2);
				aux:=operando1 / operando2;
				evalZ(raiz^.hijos[3],estado,aux, valor);
                                end;
end;
//D → valY | sqrt(D) | (expAritm)
Procedure evalD(var raiz:tarbolderivacion; var estado:tEstado;var operando1:real);
var
 lexema:string;
 valor:real;
begin
     evalD(raiz,estado,valor);
	case raiz^.hijos[1]^.simbolo of
     vval:
        begin
        evalval(raiz^.hijos[1],estado,valor);
        evalY(raiz^.hijos[2],estado);
        end;
     tsqrt:
        evalD(raiz^.hijos[3],estado,valor);
     tparenti:
        evalexpAritm(raiz^.hijos[2],estado,valor);
end;
end;
//Y → ^D | epsilon
Procedure evalY(var raiz:tarbolderivacion; var estado:tEstado);
var
 lista:tpunterolista;
begin
           if raiz^.cant > 0   then
	   evalelementos(raiz^.hijos[2],estado,lista)
end;
//val → id | const | Cantidad(id) | elemento(id, expAritm)
Procedure evalval(var raiz:tarbolderivacion; var estado:tEstado;var valor:real);
var
 error:integer;
  lista:tpunterolista;
  posicion:real;
begin
	  case raiz^.hijos[1]^.simbolo of
			tid: valor:=obtenervalor(estado, raiz^.hijos[1]^.lexema);
			tconst: val(raiz^.hijos[1]^.lexema,valor, error);
			tcantidad:begin
				lista:=obtenerlista(estado, raiz^.hijos[3]^.lexema);
				valor:= cantidad(lista);
                        end;
                        telemento:begin
				lista:=obtenerlista(estado, raiz^.hijos[3]^.lexema);
				evalexpAritm(raiz^.hijos[5],estado,posicion);
				valor:= elemento(lista, posicion);
                        end;
          end;
end;
//condicional → if disyunción then bloque E
Procedure evalcondicional(var raiz:tarbolderivacion; var estado:tEstado);
var
  valordecondicion:boolean;
begin
  evaldisyuncion(raiz^.hijos[2],estado,valordecondicion);
  evalbloque(raiz^.hijos[4],estado);
  evalE(raiz^.hijos[5],estado);
end;
//disyunción → conjunción P
Procedure evaldisyuncion(var raiz:tarbolderivacion; var estado:tEstado;var valordecondicion:boolean);
begin
     evalconjuncion(raiz^.hijos[1],estado);
     evalP(raiz^.hijos[2],estado);
end;

//P→ or conjuncion P | epsilon
Procedure evalP(var raiz:tarbolderivacion; var estado:tEstado);
begin
           if raiz^.cant > 0   then
           evalconjuncion(raiz^.hijos[2],estado) ;
end;
//conjunción → negación L
Procedure evalconjuncion(var raiz:tarbolderivacion; var estado:tEstado);
begin
evalnegacion(raiz^.hijos[1],estado);
evalL(raiz^.hijos[2],estado);
end;
//L → and negación L | epsilon
Procedure evalL(var raiz:tarbolderivacion; var estado:tEstado);
begin
  if raiz^.cant > 0   then
  evalnegacion(raiz^.hijos[2],estado);
  evalL(raiz^.hijos[3],estado);
end;
//negación → not cond | cond
Procedure evalnegacion(var raiz:tarbolderivacion; var estado:tEstado);
var
    valor:boolean;
begin
if raiz^.hijos[1]^.simbolo=tnot   then
evalcond(raiz^.hijos[2],estado,valor)
else
evalcond(raiz^.hijos[1],estado,valor)
end;
//cond →  expAritm oprel expAritm  | [disyuncion]
Procedure evalCond(var raiz:tarbolderivacion; var estado:tEstado; var valor:boolean);
var
   operando1,operando2:real;
   valordecondicion:boolean;
begin
          If raiz^.Hijos[1]^.simbolo = vexpAritm then
             begin
	   evalExpAritm(raiz^.hijos[1],estado,operando1);
           evalExpAritm(raiz^.hijos[3],estado,operando2);
           evaloprel(raiz^.hijos[2],estado)
           end
        Else
	   evaldisyuncion(raiz^.hijos[2],estado,valordecondicion);
end;
//oprel → < | > | = | >= | <=
Procedure evaloprel(var raiz:tarbolderivacion; var estado:tEstado);
var
   operando1,operando2,valor:boolean;
begin

       case raiz^.hijos[1]^.lexema of
                '<':valor:=operando1<operando2;
                '>':valor:=operando1>operando2;
                '=':valor:=operando1=operando2;
                '<=':valor:=operando1<=operando2;
                '>=':valor:=operando1>=operando2;
                end
end;
//E → epsilon | else bloque
Procedure evalE(var raiz:tarbolderivacion; var estado:tEstado);
begin
if raiz^.cant > 0  then
evalbloque(raiz^.hijos[2],estado)
end;

//para → for id = expAritm to expAritm do bloque
Procedure evalpara(var raiz:tarbolderivacion; var estado:tEstado);
var

    valorinicial,valorfinal,valor:real;
    aux,aux2,aux3:integer;
    lexema:string;

begin
       evalExparitm(raiz^.hijos[4],estado,valorinicial);
       evalExparitm(raiz^.hijos[6],estado,valorfinal);
       aux:=trunc(valor);
       aux2:=trunc(valorinicial);
       aux3:=trunc(valorfinal);
       for aux := aux2 to aux3 do
       begin
       evalBloque(raiz^.hijos[8],estado);
        raiz^.hijos[2]^.lexema:=lexema;
       end;
end;
//mientras → while disyuncion then bloque
Procedure evalmientras(var raiz:tarbolderivacion; var estado:tEstado);
var
    valordecondicion:boolean;
begin
        evalDisyuncion(raiz^.hijos[2],estado,valordecondicion);
		while valordecondicion do
			begin
                        evalBloque(raiz^.hijos[4], estado);
			evalDisyuncion(raiz^.hijos[2],estado,valordecondicion);
                        end;
end;
//leer → read(cadena,id)
Procedure evalleer(var raiz:tarbolderivacion; var estado:tEstado);
var
    aux:real;
begin
write(raiz^.hijos[3]^.lexema);
readln(aux);
AsignarValor (estado,raiz^.hijos[5]^.lexema,aux);
end;
//escribir → write(cadena,expAritm)
Procedure evalescribir(var raiz:tarbolderivacion; var estado:tEstado);
var
    valor:real;
begin
evalexparitm(raiz^.hijos[5],estado,valor);
write(raiz^.hijos[3]^.lexema);
write(valor);
end;

end.
