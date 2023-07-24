unit evaluador;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,declaraciones,math;

const
  maxlistareal=100;
  maxestado=100;

type
  tpunterolista = ^tlistareal;

  tlistareal = record
    elementos : array [1..maxlistareal] of real;
    cant:word;
  end;

  telementoestado=record
    id:string;
    tipo:simbolos;
    valorreal:real;
    valorlista:tpunterolista;
  end;

  testado=record
   elementos : array [1..maxestado] of telementoestado;
   cant:word;
  end;

//para tpunterolista

procedure inicializarlista(var l:tpunterolista); //listo
procedure agregar(var l:tpunterolista; var elemento:real);//listo
procedure eliminar(var l:tpunterolista; var posicion:real); //REVISAR
procedure reemplazar(var l:tpunterolista; var posicion:real; var elemento:real);
function cantidad(var l:tpunterolista):integer;          //listo
function elemento(var l:tpunterolista;var posicion:real):real; //listo

//para testado
procedure inicializarestado(var e:testado);
procedure agregarvariable(var e:testado; var id:string; tipo:simbolos);
procedure asignarvalor(var e:testado; var id:string;valor:real);
procedure asignarlista(var e:testado;var id:string; var l:tpunterolista);
function obtenervalor(var e:testado;var lexid:string):real;
function obtenerlista(var e:testado;var lexid:string):tpunterolista;

//para gramatica
Procedure evalPrograma(var arbol:tarbolderivacion; var estado:tEstado);
Procedure evalvariables(var arbol:tarbolderivacion; var estado:tEstado);
Procedure evalbloque(var arbol:tarbolderivacion; var estado:tEstado);
Procedure evaltipo(var arbol:tarbolderivacion; var estado:tEstado; var tipo:simbolos);
Procedure evalsentencia(var arbol:tarbolderivacion; var estado:tEstado);
Procedure evalR(var arbol:tarbolderivacion; var estado:tEstado);
Procedure evalsent(var arbol:tarbolderivacion; var estado:tEstado);
Procedure evalasig(var arbol:tarbolderivacion; var estado:tEstado);
Procedure evalA(var arbol:tarbolderivacion;var estado:testado; var lexema:string);
Procedure evalconstLista(var arbol:tarbolderivacion; var estado:tEstado;var lista:tpunterolista);
Procedure evalH(var arbol:tarbolderivacion; var estado:tEstado;var lista:tpunterolista);
Procedure evalelementos(var arbol:tarbolderivacion; var estado:tEstado;var lista:tpunterolista);
Procedure evalQ(var arbol:tarbolderivacion; var estado:tEstado;var lista:tpunterolista);
Procedure evalexpAritm(var arbol:tarbolderivacion; var estado:tEstado; var valor:real);
Procedure evalS(var arbol:tarbolderivacion; var estado:tEstado;var operando1:real;var valor:real);
Procedure evalT(var arbol:tarbolderivacion; var estado:tEstado;var operando1:real);
Procedure evalZ(var arbol:tarbolderivacion; var estado:tEstado;var operando1:real;var valor:real);
Procedure evalD(var arbol:tarbolderivacion; var estado:tEstado;var operando1:real);
Procedure evalY(var arbol:tarbolderivacion; var estado:tEstado;var operando1:real;var resultado:real);
Procedure evalval(var arbol:tarbolderivacion; var estado:tEstado;var valor:real);
Procedure evalcondicional(var arbol:tarbolderivacion; var estado:tEstado;var valordecondicion:boolean);
Procedure evaldisyuncion(var arbol:tarbolderivacion; var estado:tEstado;var valordecondicion:boolean);
Procedure evalP(var arbol:tarbolderivacion; var estado:tEstado;var operando1:boolean;var valordecondicion:boolean);
Procedure evalconjuncion(var arbol:tarbolderivacion; var estado:tEstado;var valordecondicion:boolean);
Procedure evalL(var arbol:tarbolderivacion; var estado:tEstado;var operando1:boolean;var valordecondicion:boolean);
Procedure evalnegacion(var arbol:tarbolderivacion; var estado:tEstado;var valordecondicion:boolean);
Procedure evalcond(var arbol:tarbolderivacion; var estado:tEstado;var valordecondicion:boolean);
Procedure evaloprel(var arbol:tarbolderivacion; var estado:tEstado;var operando1:real; var operando2:real; var valordecondicion:boolean);
Procedure evalE(var arbol:tarbolderivacion; var estado:tEstado);
Procedure evalpara(var arbol:tarbolderivacion; var estado:tEstado);
Procedure evalmientras(var arbol:tarbolderivacion; var estado:tEstado);
Procedure evalleer(var arbol:tarbolderivacion; var estado:tEstado);
Procedure evalescribir(var arbol:tarbolderivacion; var estado:tEstado);



implementation

PROCEDURE inicializarlista (VAR L:TPUNTEROLISTA);               //LISTO
  begin
  L^.cant:=0;
  end;
procedure agregar(var l:tpunterolista; var elemento:real);         //LISTO

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
  E.elementos[E.cant].id:=id;
  E.elementos[E.cant].tipo:=tipo;
  E.elementos[E.cant].valorReal:=0;
  E.elementos[E.cant].valorlista:=nil;
  if  tipo=tlistas then
      begin
          new(E.elementos[E.cant].valorLista);
          InicializarLista(E.elementos[E.cant].valorLista);
      end;

  end;

procedure asignarvalor(var e:testado; var id:string;valor:real);         //LISTO
var
i:integer;
begin
    For i:=1 to E.cant do
    begin
             if upcase(E.elementos[i].id)=upcase(id) then
               E.elementos[i].valorReal:=valor;
    end;
  end;
procedure asignarlista(var e:testado;var id:string; var l:tpunterolista);      //LISTO
var
i:integer;
begin
    For i:=1 to E.cant do
    begin
             if upcase(E.elementos[i].id)=upcase(id) then
               E.elementos[i].valorLista:=l;
    end;
  end;
function obtenervalor(var e:testado;var lexid:string):real;                //LISTO
var
i:integer;
begin
  obtenerValor:=0;
    For i:=1 to E.cant do
    begin
             if upcase(E.elementos[i].id)=upcase(lexid) then
                obtenerValor:=E.elementos[i].valorReal;
    end;
  end;
function obtenerlista(var e:testado;var lexid:string):tpunterolista;        //LISTO
var
i:integer;
begin
  obtenerLista:=nil;
    For i:=1 to E.cant do
    begin
             if upcase(E.elementos[i].id)=upcase(lexid) then
                obtenerLista:=E.elementos[i].valorLista;
    end;
  end;

//Programa → variables bloque
Procedure evalPrograma(var arbol:tarbolderivacion; var estado:tEstado);
  begin
          evalvariables(arbol^.hijos[1],estado);
	  evalBloque(arbol^.hijos[2],estado);
  end;
//variables → id tipo variables | epsilon
Procedure evalvariables(var arbol:tarbolderivacion; var estado:tEstado);
var
  //resultado:simbolos;
  tipo:simbolos;
  begin
       if arbol^.cant > 0 then
          begin
            evaltipo(arbol^.hijos[2],estado,tipo);
            AgregarVariable(estado, arbol^.hijos[1]^.lexema , tipo);
            evalvariables(arbol^.hijos[3],estado);
          end;
   end;
//bloque → begin sentencia end
Procedure evalbloque(var arbol:tarbolderivacion; var estado:tEstado);
begin
         evalsentencia(arbol^.hijos[2],estado);
end;
//tipo → lista | real
Procedure evaltipo(var arbol:tarbolderivacion; var estado:tEstado; var  tipo:simbolos);
begin
if arbol^.hijos[1]^.simbolo = tlistas then
   tipo:=tlistas
   else
   tipo:=treal;
end;

//sentencia → sentR
Procedure evalsentencia(var arbol:tarbolderivacion; var estado:tEstado);

begin
        evalSent(arbol^.hijos[1],estado);
	evalR(arbol^.hijos[2],estado);
end;
//R → sentR | epsilon
Procedure evalR(var arbol:tarbolderivacion; var estado:tEstado);
begin
  If arbol^.cant>0 then
        begin
	evalSent(arbol^.hijos[1],estado);
        evalR(arbol^.hijos[2],estado);
        end;
 end;
//sent → asig; | condicional; | para; | mientras; | leer; | escribir; | agregar(id, expAritm); | eliminar(id, expAritm); | reemplazar(id, expAritm, expAritm);
Procedure evalSent(var arbol:tarbolderivacion; var estado:tEstado);
      var
        valor:real;
        lexema:string;
        lista:tPunteroLista;
        posicion:real;

        valordecondicion:boolean;
begin

  case arbol^.hijos[1]^.simbolo of
       vasig:evalAsig(arbol^.hijos[1],estado);

       vcondicional: evalcondicional(arbol^.hijos[1],estado,valordecondicion);

       vpara:evalpara(arbol^.hijos[1],estado);

       vmientras:evalmientras(arbol^.hijos[1],estado);

       vleer:evalleer(arbol^.hijos[1],estado);

       vescribir:evalescribir(arbol^.hijos[1],estado);

       tagregar: begin


                evalexpAritm(arbol^.hijos[5],estado,valor);
                lista:=obtenerLista(estado,arbol^.hijos[3]^.lexema);
	        agregar(lista,valor);
           end;
       teliminar:begin
               evalexpAritm(arbol^.hijos[5],estado,valor);
	       lista:=obtenerlista(estado,arbol^.hijos[3]^.lexema);
	       eliminar(lista,posicion);
           end;
       treemplazar:begin
		evalexpAritm(arbol^.hijos[5],estado,posicion);
		lista:=obtenerlista(estado,arbol^.hijos[3]^.lexema);
                evalexpAritm(arbol^.hijos[7],estado,valor);
                reemplazar(lista,posicion,valor);
           end;
       end;

  end;
//asig → id opAsig A
Procedure evalAsig(var arbol:tarbolderivacion;var estado:tEstado);
begin
  evalA(arbol^.hijos[3],estado,arbol^.hijos[1]^.lexema);
end;
//A → expAritm | constLISTA
Procedure evalA(var arbol:tarbolderivacion; var estado:tEstado;var lexema:string);
var
  Lista:TpunteroLista;
  valor:real;
begin
	  if arbol^.hijos[1]^.simbolo=vexpAritm    then
                        begin
                        evalexpAritm(arbol^.hijos[1],estado,valor);
			asignarvalor(estado,lexema,valor);
                        end
                        else
                        begin
			evalconstLista(arbol^.hijos[1],estado,lista);
			asignarlista(estado,lexema,lista);
                        end;
 end;

//constLISTA → [H]
Procedure evalconstLista(var arbol:tarbolderivacion; var estado:tEstado;var lista:tpunterolista);
begin
                new(lista);
		inicializarlista(lista);
		evalH(arbol^.hijos[2],estado, lista) ;
end;
//H → elementos | epsilon
Procedure evalH(var arbol:tarbolderivacion; var estado:tEstado;var lista:tpunterolista);
begin
		if arbol^.cant > 0  then
			evalelementos(arbol^.hijos[1],estado,lista)
  end;
//elementos → expAritmQ
Procedure evalelementos(var arbol:tarbolderivacion; var estado:tEstado;var lista:tpunterolista);
var
  valor:real;
begin
		evalexpAritm(arbol^.hijos[1],estado,valor);
		agregar(lista,valor);
                evalQ(arbol^.hijos[2],estado,lista);
        end;
//Q → ,elementos | epsilon
Procedure evalQ(var arbol:tarbolderivacion; var estado:tEstado;var lista:tpunterolista);
begin
                if arbol^.cant > 0   then
                evalelementos(arbol^.hijos[2],estado,lista)
end;

//expAritm →  TS
Procedure evalexpAritm(var arbol:tarbolderivacion; var estado:tEstado;var valor:real);
var
operando1:real;

begin
evalT(arbol^.hijos[1],estado,operando1);
evalS(arbol^.hijos[2],estado,operando1,valor);

end;

//S → +TS | -TS | epsilon
Procedure evalS(var arbol:tarbolderivacion; var estado:tEstado;var operando1:real;var valor:real);
var
  operando2:real;

  aux:real;
begin
         if arbol^.cant = 0      then
			valor:=operando1
		else
			if arbol^.hijos[1]^.simbolo = tmas then
                           begin
				evalT(arbol^.hijos[2],estado,operando2);
				aux:=operando1 + operando2;
				evalS(arbol^.hijos[3],estado,aux, valor);
                           end
                        else
                        begin
				evalT(arbol^.hijos[2],estado,operando2);
				aux:=operando1 - operando2;
				evalS(arbol^.hijos[3],estado,aux, valor);
                        end;

end;
//T → DZ
Procedure evalT(var arbol:tarbolderivacion; var estado:tEstado;var operando1:real);
var
   valor:real;
begin
  evalD(arbol^.hijos[1],estado,valor);
  evalZ(arbol^.hijos[2],estado,valor,operando1);
end;
//Z → *DZ | /DZ | epsilon
Procedure evalZ(var arbol:tarbolderivacion; var estado:tEstado;var operando1:real;var valor:real);
var
   operando2,aux:real;
begin
        if arbol^.cant = 0       then
			valor:=operando1
		else
			if arbol^.hijos[1]^.simbolo = tmultiplicar then
                           begin
				evalD(arbol^.hijos[2],estado,operando2);
				aux:=operando1 * operando2;
				evalZ(arbol^.hijos[3],estado,aux, valor);
                                end
			else
                        begin
				evalD(arbol^.hijos[2],estado,operando2);
				aux:=operando1 / operando2;
				evalZ(arbol^.hijos[3],estado,aux, valor);
                                end;
end;
//D → valY | sqrt(D)
Procedure evalD(var arbol:tarbolderivacion; var estado:tEstado;var operando1:real);
var
 lexema:string;
 valor:real;
 aux:real;
begin

	case arbol^.hijos[1]^.simbolo of
     vval:
        begin
        evalval(arbol^.hijos[1],estado,valor);
        evalY(arbol^.hijos[2],estado,valor,operando1);
        end;
     tsqrt:
        begin
        evalD(arbol^.hijos[3],estado,valor);
        operando1:=sqrt(valor);
        end;

end;
end;
//Y → ^D | epsilon
Procedure evalY(var arbol:tarbolderivacion; var estado:tEstado;var operando1:real;var resultado:real);
var
 exponente:real;
begin
           if arbol^.cant > 0   then
           begin
	   evalD(arbol^.hijos[2],estado,exponente);
           resultado:=power(operando1,exponente);
           end
           else
           resultado:=operando1;
end;
//val → id | const | Cantidad(id) | elemento(id, expAritm) | (expAritm)
Procedure evalval(var arbol:tarbolderivacion; var estado:tEstado;var valor:real);
var
 error:integer;
  lista:tpunterolista;
  posicion:real;
begin
	  case arbol^.hijos[1]^.simbolo of
			tid: valor:=obtenervalor(estado, arbol^.hijos[1]^.lexema);
			tconst: val(arbol^.hijos[1]^.lexema,valor, error);
			tcantidad:begin
				lista:=obtenerlista(estado, arbol^.hijos[3]^.lexema);
				valor:= cantidad(lista);
                        end;
                        telemento:begin
				lista:=obtenerlista(estado, arbol^.hijos[3]^.lexema);
				evalexpAritm(arbol^.hijos[5],estado,posicion);
				valor:= elemento(lista, posicion);
                        end;
                        tparenti:
                                  evalexpAritm(arbol^.hijos[2],estado,valor);
          end;
end;
//condicional → if disyunción then bloque E
Procedure evalcondicional(var arbol:tarbolderivacion; var estado:tEstado;var valordecondicion:boolean);
{var
  valordecondicion:boolean;  }
begin
  evaldisyuncion(arbol^.hijos[2],estado,valordecondicion);
  if valordecondicion then
  evalbloque(arbol^.hijos[4],estado)
  else
  evalE(arbol^.hijos[5],estado)
end;
//disyunción → conjunción P
Procedure evaldisyuncion(var arbol:tarbolderivacion; var estado:tEstado;var valordecondicion:boolean);
var
  operando1:boolean;
begin

     evalconjuncion(arbol^.hijos[1],estado,operando1);
     evalP(arbol^.hijos[2],estado,operando1,valordecondicion);
end;

//P→ or conjuncion P | epsilon
Procedure evalP(var arbol:tarbolderivacion; var estado:tEstado;var operando1:boolean;var valordecondicion:boolean);
var
operando2,aux:boolean;
begin
           if arbol^.cant > 0   then
           //evalconjuncion(arbol^.hijos[2],estado,valordecondicion) ;
         begin
         evalConjuncion(arbol^.hijos[2],estado, operando2);
	aux:=operando1  or operando2;
        evalP(arbol^.hijos[3],estado, aux ,valordecondicion);
        end
        else
        valordecondicion:=operando1;


end;
//conjunción → negación L
Procedure evalconjuncion(var arbol:tarbolderivacion; var estado:tEstado;var valordecondicion:boolean);
var
  operando1:boolean;
begin
evalnegacion(arbol^.hijos[1],estado,operando1);
evalL(arbol^.hijos[2],estado,operando1,valordecondicion);
end;
//L → and negación L | epsilon
Procedure evalL(var arbol:tarbolderivacion; var estado:tEstado;var operando1:boolean;var valordecondicion:boolean);
 var
   operando2:boolean;
   aux:boolean;
begin
  if arbol^.cant > 0   then
  begin
  evalnegacion(arbol^.hijos[2],estado,valordecondicion);
  aux:=operando1  and operando2;
  evalL(arbol^.hijos[3],estado,aux,valordecondicion);
  end
  else
  valordecondicion:=operando1;
end;
//negación → not cond | cond
Procedure evalnegacion(var arbol:tarbolderivacion; var estado:tEstado;var valordecondicion:boolean);

begin
if arbol^.hijos[1]^.simbolo=tnot   then
begin
evalcond(arbol^.hijos[2],estado,valordecondicion) ;
valordecondicion:=not valordecondicion   ;
end
else
evalcond(arbol^.hijos[1],estado,valordecondicion)
end;
//cond →  expAritm oprel expAritm  | [disyuncion]
Procedure evalCond(var arbol:tarbolderivacion; var estado:tEstado;var valordecondicion:boolean);
var
   operando1,operando2:real;
begin
          If arbol^.Hijos[1]^.simbolo = vexpAritm then
             begin
	   evalExpAritm(arbol^.hijos[1],estado,operando1);
           evalExpAritm(arbol^.hijos[3],estado,operando2);
           evaloprel(arbol^.hijos[2],estado,operando1,operando2,valordecondicion);
           end
        Else
	   evaldisyuncion(arbol^.hijos[2],estado,valordecondicion);
end;
//oprel → < | > | = | >= | <=
Procedure evaloprel(var arbol:tarbolderivacion; var estado:tEstado;var operando1:real; var operando2:real; var valordecondicion:boolean);
begin
       case arbol^.hijos[1]^.simbolo of
                tmenor:valordecondicion:=operando1<operando2;
                tmayor:valordecondicion:=operando1>operando2;
                tigual:valordecondicion:=operando1=operando2;
                tmenorigual:valordecondicion:=operando1<=operando2;
                tmayorigual:valordecondicion:=operando1>=operando2;
                end
end;
//E → epsilon | else bloque
Procedure evalE(var arbol:tarbolderivacion; var estado:tEstado);
begin
if arbol^.cant > 0  then
evalbloque(arbol^.hijos[2],estado)
end;

//para → for id = expAritm to expAritm do bloque
Procedure evalpara(var arbol:tarbolderivacion; var estado:tEstado);
var

    valorinicial,valorfinal,valor:real;
    aux,aux2,aux3:integer;
    lexema:string;

begin
       evalExparitm(arbol^.hijos[4],estado,valorinicial);
       evalExparitm(arbol^.hijos[6],estado,valorfinal);
       aux2:=trunc(valorinicial);
       aux3:=trunc(valorfinal);
       for aux := aux2 to aux3 do
       begin
       asignarvalor(estado,arbol^.hijos[2]^.lexema,aux);
       evalBloque(arbol^.hijos[8],estado);
       end;
end;
//mientras → while disyuncion then bloque
Procedure evalmientras(var arbol:tarbolderivacion; var estado:tEstado);
var
    valordecondicion:boolean;
begin
        evalDisyuncion(arbol^.hijos[2],estado,valordecondicion);
		while valordecondicion do
			begin
                        evalBloque(arbol^.hijos[4], estado);
			evalDisyuncion(arbol^.hijos[2],estado,valordecondicion);
                        end;
end;
//leer → read(cadena,id)
Procedure evalleer(var arbol:tarbolderivacion; var estado:tEstado);
var
    aux:real;
begin
write(arbol^.hijos[3]^.lexema);
readln(aux);
AsignarValor (estado,arbol^.hijos[5]^.lexema,aux);
end;
//escribir → write(cadena,expAritm)
Procedure evalescribir(var arbol:tarbolderivacion; var estado:tEstado);
var
    valor:real;
begin
evalexparitm(arbol^.hijos[5],estado,valor);
write(arbol^.hijos[3]^.lexema);
writeln(valor:9:2);
end;

end.
