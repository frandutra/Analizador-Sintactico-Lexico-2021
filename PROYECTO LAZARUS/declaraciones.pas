unit declaraciones;
 interface
 uses crt;
 const
   celdavacia=-1;



type

 archivo=file of char;

 simbolos=(error,{epsilon,}tlistas, treal, {error,epsilon,tipos}
 tid, topAsig, tconst,  {id,:¬,const}
 tmas, tmenos, tdividir, tmultiplicar, tpotencia, tsqrt, tcorchi,tcorchf, tparenti, tparentf,  {oparitm}
 tif, tthen,telse, tbegin, tend, tfor, tto, tread, twrite, twhile,tdo,   {estructuras}
 tmayor,tmenor,tmayorigual,tmenorigual,tigual,     {oprel}
 tor, tand, tnot,         {oplogicas}
 tdospuntos, tpuntoycoma, tcoma,    {:,;,,}
 tcadena,tagregar,teliminar, treemplazar, tcantidad, telemento,pesos,  {procedimientos}
 vprograma, vvariables, vtipo,voprel, vsentencia, vsent, vasig, vA, vconstLista, velementos, vexpAritm, vT, vD, vval,                                                    {vVARIABLES}
 vcondicional, vdisyuncion, vconjuncion, vnegacion, vK, vcond, vE, vbloque, vpara, vmientras, vleer, vescribir,vF,vM,vQ, vR, vH, vS, vZ, vY, vX,vP,vL);


 terminales=tlistas..pesos;

 variables=vprograma..vL;

 tdatol=simbolos;

 tpunterol=^tnodo;

 tnodo=record
        info:simbolos;
        sig:tpunterol;
       end;

 tlista=record
          cab:tpunterol;
          tam:integer;
          act:tpunterol;
         end;

 tas = array [variables,terminales] of tlista;

 tarbolderivacion=^tnodoarbol;


 tdatop=record
        x:simbolos;
        parbol:tarbolderivacion;

 end;

 tpunterop=^tnodop;
 tnodop= record
        info:tdatop;
        sig: tpunterop;
       end;

 tpila= record
        tope:tpunterop;
        tam:cardinal;
       end;

 tdatotabla=simbolos;

 tpunterotabla=^tnodotabla;

 tnodotabla=record
             lex:string;
             comp:tdatotabla;
             sig:tpunterotabla;
            end;

 ttabla= record
          cab:tpunterotabla;
          tam:cardinal;
         end;



 tnodoarbol= record
 simbolo:simbolos;
 lexema:string;
 hijos:array[1..10] of tarbolderivacion;
 cant:byte;

 end;


procedure crearlista (var l:tlista);
procedure insertarl(var l:tlista;x:tdatol);
function  tamaniolista(l:tlista):cardinal;
procedure primero(var l:tlista);
procedure siguiente(var l:tlista);
procedure leeractual(var l:tlista; var elemento:simbolos);
function finlista(var l:tlista):boolean;


procedure crearnodo(var arbol:tarbolderivacion;elemento:simbolos);                                {arbol}
procedure ihijo(var arbol:tarbolderivacion;i:byte;var simbolo:simbolos;var puntero:tarbolderivacion);
procedure agregarhijo(var padre:tarbolderivacion;var hijo:tarbolderivacion);
function canthijos(var arbol:tarbolderivacion):byte;
 //procedure guardarArbol(var ar:text; var raiz: tarbolderivacion; Desplazamiento:integer);


procedure crearp(var p:tpila);
procedure apilar(var p:tpila; x:tdatop);
procedure eliminarp(var p:tpila;var x:tdatop);
procedure ruta(var n:string; var r:string);


 procedure creartabla(var l:ttabla);
procedure agregartabla(var l:ttabla; lexema:string; comp:terminales);
procedure busqentabla(var l:ttabla; lexema:string;var comp:simbolos);


implementation
procedure crearlista (var l:tlista);
begin
 l.cab:=nil;
 l.tam:=celdavacia;
end;

procedure insertarl(var l:tlista;x:tdatol);
var aux,ant,act:tpunterol;

begin
 if l.tam=celdavacia then l.tam:=0;
 inc(l.tam);
 new(aux);
 aux^.info:=x;
  if (l.cab=nil) then
   begin
    aux^.sig:=l.cab;
    l.cab:=aux;
   end
  else
   begin
    ant:=l.cab;
    act:=l.cab^.sig;
     while (act<>nil)  do
      begin
       ant:=act;
       act:=act^.sig;
      end;
    aux^.sig:=act;
    ant^.sig:=aux;
   end;
end;

function  tamaniolista(l:tlista):cardinal;

begin
 tamaniolista:=l.tam;
end;

procedure crearp(var p:tpila);

begin
p.tope:=nil;
p.tam:=0;
end;

procedure apilar(var p:tpila; x:tdatop);
var aux:tpunterop;

begin
new(aux);
aux^.info:=x;
aux^.sig:=p.tope;
p.tope:=aux;
inc(p.tam);
end;

procedure eliminarp(var p:tpila;var x:tdatop);
var aux:tpunterop;

begin
x:=p.tope^.info;
aux:=p.tope;
p.tope:=aux^.sig;
dispose(aux);
dec(p.tam);
end;

procedure ruta(var n:string; var r:string);
Var aux1,aux2,aux3:string;
 begin
   aux1:='C:\DRW\';
   aux2:='.txt';
   gotoxy(74,13);
   readln(n);
   gotoxy(74,16);
   readln(aux3);
   r:=aux1+aux3+aux2;
 end;

procedure creartabla(var l:ttabla);
begin
 l.cab:=nil;
 l.tam:=0;
end;

procedure busqentabla(var l:ttabla; lexema:string;var comp:simbolos);
   var act:tpunterotabla;
        encontrado:boolean;
  begin
   encontrado:=false;
   act:=l.cab;
    while (act <> nil)and (not encontrado) do
     begin

      if upcase(act^.lex)=upcase(lexema) then
       begin
       comp:=act^.comp;
       encontrado:=true;
       end
      else
       act:=act^.sig;
     end;
    if act=nil then
     comp:=tid;
  end;

procedure agregartabla(var l:ttabla; lexema:string;comp:terminales);
 var aux,ant,act:tpunterotabla;

begin
 inc(l.tam);
 new(aux);
 aux^.lex:=lexema;
 aux^.comp:=comp;
  if l.cab=nil  then
   begin
    aux^.sig:=l.cab;
    l.cab:=aux;
   end
  else
   begin
    ant:=l.cab;
    act:=l.cab^.sig;
     while act<>nil  do
      begin
       ant:=act;
       act:=act^.sig;
      end;
    aux^.sig:=act;
    ant^.sig:=aux;
   end;
end;

procedure primero(var l:tlista);
begin
l.act:=l.cab;
end;

procedure siguiente(var l:tlista);
begin
l.act:=l.act^.sig;
end;

procedure leeractual(var l:tlista; var elemento:simbolos);
begin
elemento:=l.act^.info;
end;

function finlista(var l:tlista):boolean;
begin
finlista:=l.act=nil;
end;

procedure crearnodo(var arbol:tarbolderivacion;elemento:simbolos);                                {arbol}
begin
new(arbol);
arbol^.simbolo:=elemento;
arbol^.lexema:='';
arbol^.cant:=0;
end;

procedure ihijo(var arbol:tarbolderivacion;i:byte;var simbolo:simbolos;var puntero:tarbolderivacion);
begin
puntero:=arbol^.hijos[i];
simbolo:=puntero^.simbolo;
end;

procedure agregarhijo(var padre:tarbolderivacion;var hijo:tarbolderivacion);
begin
inc(padre^.cant);
padre^.hijos[padre^.cant]:=hijo;
end;

function canthijos(var arbol:tarbolderivacion):byte;
begin
canthijos:=arbol^.cant;         {//////////////////////}
end;

END.

