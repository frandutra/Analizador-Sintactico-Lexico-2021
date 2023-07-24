unit anasin;


interface

uses declaraciones,analex,crt;

procedure analizadorsint(r:string;var raiz:tarbolderivacion; var s:boolean);


implementation
procedure creartablasim(var l:ttabla);
begin
creartabla(l);
agregartabla(l,'lista',tlistas);
agregartabla(l,'real',treal);          {tipos}

agregartabla(l,'const',tconst);   {id,:¬,const}


agregartabla(l,'sqrt',tsqrt);          {oparitm}

agregartabla(l,'if',tif);
agregartabla(l,'then',tthen);
agregartabla(l,'else',telse);
agregartabla(l,'begin',tbegin);
agregartabla(l,'end',tend);
agregartabla(l,'for',tfor);
agregartabla(l,'to',tto);
agregartabla(l,'read',tread);
agregartabla(l,'write',twrite);
agregartabla(l,'while',twhile);
agregartabla(l,'do',tdo);               {estructuras}

agregartabla(l,'or',tor);
agregartabla(l,'and',tand);                {oplogicas}
agregartabla(l,'not',tnot);

agregartabla(l,'cadena',tcadena);
agregartabla(l,'agregar',tagregar);
agregartabla(l,'eliminar',teliminar);
agregartabla(l,'reemplazar',treemplazar);
agregartabla(l,'cantidad',tcantidad);              {procedimientos}
agregartabla(l,'elemento',telemento);


end;

procedure creartas(var tabla:tas);
  var
    I, K : simbolos;
  begin
    for K := vprograma to vL do
   begin
     for I:= tlistas to pesos do
     begin
       crearlista(Tabla[k,i]);
     end;
  end;

    //PROGRAMA -> VARIABLES BLOQUE
    insertarl(Tabla[vprograma,tid],vvariables);
    insertarl(Tabla[vprograma,tid],vbloque);

    insertarl(Tabla[vprograma,tbegin],vvariables);
    insertarl(Tabla[vprograma,tbegin],vbloque);

    //VARIABLES -> ID TIPO VARIABLES | EPSILON
    insertarl(Tabla[vvariables,tid],tid);
    insertarl(Tabla[vvariables,tid],vtipo);
    insertarl(Tabla[vvariables,tid],vvariables);

    Tabla[vvariables,tbegin].tam:=0;

    //TIPO -> REAL | LISTA
    insertarl(Tabla[vtipo,tlistas],tlistas);
    insertarl(Tabla[vtipo,treal],treal);

    //SENTENCIA -> SENT R
    insertarl(Tabla[vsentencia,tid],vsent);
    insertarl(Tabla[vsentencia,tid],vR);

    insertarl(Tabla[vsentencia,tif],vsent);
    insertarl(Tabla[vsentencia,tif],vR);

    insertarl(Tabla[vsentencia,tfor],vsent);
    insertarl(Tabla[vsentencia,tfor],vR);

    insertarl(Tabla[vsentencia,tread],vsent);
    insertarl(Tabla[vsentencia,tread],vR);

    insertarl(Tabla[vsentencia,twrite],vsent);
    insertarl(Tabla[vsentencia,twrite],vR);

    insertarl(Tabla[vsentencia,twhile],vsent);
    insertarl(Tabla[vsentencia,twhile],vR);

    insertarl(Tabla[vsentencia,treemplazar],vsent);
    insertarl(Tabla[vsentencia,treemplazar],vR);

    insertarl(Tabla[vsentencia,tagregar],vsent);
    insertarl(Tabla[vsentencia,tagregar],vR);

    insertarl(Tabla[vsentencia,teliminar],vsent);
    insertarl(Tabla[vsentencia,teliminar],vR );


    //SENT -> ASIG; | CONDICIONAL; | PARA; | MIENTRAS; | LEER; | ESCRIBIR; | AGREGAR(ID, EXPARITM); | ELIMINAR(ID, EXPARITM); | REEMPLAZAR(ID, EXPARITM, EXPARITM);
    insertarl(Tabla[vsent,tid],vasig);
    insertarl(Tabla[vsent,tid],tpuntoycoma);

    insertarl(Tabla[vsent,tif],vcondicional);
    insertarl(Tabla[vsent,tif],tpuntoycoma);

    insertarl(Tabla[vsent,tfor],vpara);
    insertarl(Tabla[vsent,tfor],tpuntoycoma);

    insertarl(Tabla[vsent,tread],vleer);
    insertarl(Tabla[vsent,tread],tpuntoycoma);

    insertarl(Tabla[vsent,twrite],vescribir);
    insertarl(Tabla[vsent,twrite],tpuntoycoma);

    insertarl(Tabla[vsent,twhile],vmientras);
    insertarl(Tabla[vsent,twhile],tpuntoycoma);

    insertarl(Tabla[vsent,treemplazar],treemplazar);
    insertarl(Tabla[vsent,treemplazar],tparenti);
    insertarl(Tabla[vsent,treemplazar],tid );
    insertarl(Tabla[vsent,treemplazar],tcoma );
    insertarl(Tabla[vsent,treemplazar],vexpAritm );
    insertarl(Tabla[vsent,treemplazar],tcoma);
    insertarl(Tabla[vsent,treemplazar],vexpAritm);
    insertarl(Tabla[vsent,treemplazar],tparentf);
    insertarl(Tabla[vsent,treemplazar],tpuntoycoma);

    insertarl(Tabla[vsent,tagregar],tagregar);
    insertarl(Tabla[vsent,tagregar],tparenti);
    insertarl(Tabla[vsent,tagregar],tid );
    insertarl(Tabla[vsent,tagregar],tcoma );
    insertarl(Tabla[vsent,tagregar],vexpAritm );
    insertarl(Tabla[vsent,tagregar],tparentf );
    insertarl(Tabla[vsent,tagregar],tpuntoycoma);

    insertarl(Tabla[vsent,teliminar],teliminar);
    insertarl(Tabla[vsent,teliminar],tparenti);
    insertarl(Tabla[vsent,teliminar],tid);
    insertarl(Tabla[vsent,teliminar],tcoma);
    insertarl(Tabla[vsent,teliminar],vexpAritm);
    insertarl(Tabla[vsent,teliminar],tparentf);
    insertarl(Tabla[vsent,teliminar],tpuntoycoma);


    //ASIG -> ID OPASIG A
    insertarl(Tabla[vasig,tid],tid);
    insertarl(Tabla[vasig,tid],topAsig);
    insertarl(Tabla[vasig,tid],vA);



    //A -> EXPARIT | CONSTLIST
    insertarl(Tabla[vA,tid],vexpAritm);

    insertarl(Tabla[vA,tcorchi],vconstLista);

    insertarl(Tabla[vA,tconst],vexpAritm);

    insertarl(Tabla[vA,tcantidad],vexpAritm);

    insertarl(Tabla[vA,telemento],vexpAritm);

    insertarl(Tabla[vA,tparenti],vexpAritm);

    insertarl(Tabla[vA,tsqrt],vexpAritm);

    //CONSTLISTA -> [H]
    insertarl(Tabla[vconstLista,tcorchi],tcorchi);
    insertarl(Tabla[vconstLista,tcorchi],vH );
    insertarl(Tabla[vconstLista,tcorchi],tcorchf);

    //ELEMENTOS -> EXPARITQ
    insertarl(Tabla[velementos,tid],vexpAritm);
    insertarl(Tabla[velementos,tid],vQ);

    insertarl(Tabla[velementos,tcantidad],vexpAritm);
    insertarl(Tabla[velementos,tcantidad],vQ);

    insertarl(Tabla[velementos,tconst],vexpAritm);
    insertarl(Tabla[velementos,tconst],vQ);

    insertarl(Tabla[velementos,telemento],vexpAritm);
    insertarl(Tabla[velementos,telemento],vQ);

    insertarl(Tabla[velementos,tsqrt],vexpAritm);
    insertarl(Tabla[velementos,tsqrt],vQ);

    insertarl(Tabla[velementos,tparenti],vexpAritm);
    insertarl(Tabla[velementos,tparenti],vQ);

    //EXPARIT -> TS
    insertarl(Tabla[vexpAritm,tid],vT);
    insertarl(Tabla[vexpAritm,tid],vS);

    insertarl(Tabla[vexpAritm,tconst],vT);
    insertarl(Tabla[vexpAritm,tconst],vS);

    insertarl(Tabla[vexpAritm,tcantidad],vT);
    insertarl(Tabla[vexpAritm,tcantidad],vS);

    insertarl(Tabla[vexpAritm,telemento],vT);
    insertarl(Tabla[vexpAritm,telemento],vS);

    insertarl(Tabla[vexpAritm,tsqrt],vT);
    insertarl(Tabla[vexpAritm,tsqrt],vS);

    insertarl(Tabla[vexpAritm,tparenti],vT);
    insertarl(Tabla[vexpAritm,tparenti],vS);



    //T -> DZ
    insertarl(Tabla[vT,tid],vD);
    insertarl(Tabla[vT,tid],vZ);

    insertarl(Tabla[vT,tconst],vD);
    insertarl(Tabla[vT,tconst],vZ);

    insertarl(Tabla[vT,tcantidad],vD);
    insertarl(Tabla[vT,tcantidad],vZ);

    insertarl(Tabla[vT,telemento],vD);
    insertarl(Tabla[vT,telemento],vZ);

    insertarl(Tabla[vT,tsqrt],vD);
    insertarl(Tabla[vT,tsqrt],vZ);

    insertarl(Tabla[vT,tparenti],vD);
    insertarl(Tabla[vT,tparenti],vZ);


    //Q -> ,ELEMENTOSQ | EPSILON
    insertarl(Tabla[vQ,tcoma],tcoma);
    insertarl(Tabla[vQ,tcoma],velementos);

    Tabla[vQ,tcorchf].tam:=0;

    //D -> VAL^Y | SQRT(D)
    insertarl(Tabla[vD,tid],vval);
    insertarl(Tabla[vD,tid],vY);

    insertarl(Tabla[vD,tconst],vval);
    insertarl(Tabla[vD,tconst],vY);

    insertarl(Tabla[vD,tcantidad],vval);
    insertarl(Tabla[vD,tcantidad],vY);

    insertarl(Tabla[vD,telemento],vval);
    insertarl(Tabla[vD,telemento],vY);

    insertarl(Tabla[vD,tparenti],vval);
    insertarl(Tabla[vD,tparenti],vY);

    insertarl(Tabla[vD,tsqrt],tsqrt);
    insertarl(Tabla[vD,tsqrt],tparenti);
    insertarl(Tabla[vD,tsqrt],vD);
    insertarl(Tabla[vD,tsqrt],tparentf);





    //Y -> ^D | EPSILON
    Tabla[vY,tcorchf].tam:=0;
    Tabla[vY,tparentf].tam:=0;
    Tabla[vY,tthen].tam:=0;
    Tabla[vY,tor].tam:=0;
    Tabla[vY,tand].tam:=0;
    Tabla[vY,tdo].tam:=0;
    Tabla[vY,tto].tam:=0;
    Tabla[vY,tmas].tam:=0;
    Tabla[vY,tmenos].tam:=0;
    Tabla[vY,tmultiplicar].tam:=0;
    Tabla[vY,tdividir].tam:=0;
    Tabla[vY,tcoma].tam:=0;
    Tabla[vY,tmenor].tam:=0;
    Tabla[vY,tmayor].tam:=0;
    Tabla[vY,tigual].tam:=0;
    Tabla[vY,tpuntoycoma].tam:=0;
    Tabla[vY,tmayorigual].tam:=0;
    Tabla[vY,tmenorigual].tam:=0;

    insertarl(Tabla[vY,tpotencia],tpotencia);
    insertarl(Tabla[vY,tpotencia],vD);

    //VAL -> ID | CONST | CANTIDAD(ID) | EELEMENTO(ID,EXPARIT)
    insertarl(Tabla[vval,tid],tid);

    insertarl(Tabla[vval,tconst],tconst);

     insertarl(Tabla[vval,tcantidad],tcantidad);
     insertarl(Tabla[vval,tcantidad],tparenti);
     insertarl(Tabla[vval,tcantidad],tid);
     insertarl(Tabla[vval,tcantidad],tparentf);

     insertarl(Tabla[vval,tparenti],tparenti);
     insertarl(Tabla[vval,tparenti],vexpAritm);
     insertarl(Tabla[vval,tparenti],tparentf);

     insertarl(Tabla[vval,telemento],telemento);
     insertarl(Tabla[vval,telemento],tparenti);
     insertarl(Tabla[vval,telemento],tid);
     insertarl(Tabla[vval,telemento],tcoma);
     insertarl(Tabla[vval,telemento],vexpAritm);
     insertarl(Tabla[vval,telemento],tparentf);

     //CONDICIONAL -> IF DISYUNCION THEN BLOQUE E
     insertarl(Tabla[vcondicional,tif],tif);
     insertarl(Tabla[vcondicional,tif],vdisyuncion);
     insertarl(Tabla[vcondicional,tif],tthen);
     insertarl(Tabla[vcondicional,tif],vbloque);
     insertarl(Tabla[vcondicional,tif],vE);

     //DISYUNCION -> CONJUNCION P
     insertarl(Tabla[vdisyuncion,tnot],vconjuncion);
     insertarl(Tabla[vdisyuncion,tnot],vP);

     insertarl(Tabla[vdisyuncion,tsqrt],vconjuncion);
     insertarl(Tabla[vdisyuncion,tsqrt],vP);

     insertarl(Tabla[vdisyuncion,tid],vconjuncion);
     insertarl(Tabla[vdisyuncion,tid],vP);

     insertarl(Tabla[vdisyuncion,tconst],vconjuncion);
     insertarl(Tabla[vdisyuncion,tconst],vP);

     insertarl(Tabla[vdisyuncion,tcantidad],vconjuncion);
     insertarl(Tabla[vdisyuncion,tcantidad],vP);

     insertarl(Tabla[vdisyuncion,telemento],vconjuncion);
     insertarl(Tabla[vdisyuncion,telemento],vP);

     insertarl(Tabla[vdisyuncion,tparenti],vconjuncion);
     insertarl(Tabla[vdisyuncion,tparenti],vP);


     //CONJUNCION -> NEGACION L
     insertarl(Tabla[vconjuncion,tid],vnegacion);
     insertarl(Tabla[vconjuncion,tid],vL);

     insertarl(Tabla[vconjuncion,tconst],vnegacion);
     insertarl(Tabla[vconjuncion,tconst],vL);

     insertarl(Tabla[vconjuncion,tcantidad],vnegacion);
     insertarl(Tabla[vconjuncion,tcantidad],vL);

     insertarl(Tabla[vconjuncion,telemento],vnegacion);
     insertarl(Tabla[vconjuncion,telemento],vL);

     insertarl(Tabla[vconjuncion,tsqrt],vnegacion);
     insertarl(Tabla[vconjuncion,tsqrt],vL);

     insertarl(Tabla[vconjuncion,tnot],vnegacion);
     insertarl(Tabla[vconjuncion,tnot],vL);

     insertarl(Tabla[vconjuncion,tparenti],vnegacion);
     insertarl(Tabla[vconjuncion,tparenti],vL);

     //NEGACION -> NOT COND | COND
     insertarl(Tabla[vnegacion,tid],vcond);

     insertarl(Tabla[vnegacion,tconst],vcond);

     insertarl(Tabla[vnegacion,tcantidad],vcond);

     insertarl(Tabla[vnegacion,telemento],vcond);

     insertarl(Tabla[vnegacion,tsqrt],vcond);

     insertarl(Tabla[vnegacion,tparenti],vcond);

     insertarl(Tabla[vnegacion,tnot],tnot);
     insertarl(Tabla[vnegacion,tnot],vcond);

     //L -> AND NEGACION L | EPSILON
     Tabla[vL,tthen].tam:=0;
     Tabla[vL,tor].tam:=0;
     Tabla[vL,tcorchf].tam:=0;
     insertarl(Tabla[vL,tand],tand);
     insertarl(Tabla[vL,tand],vnegacion);
     insertarl(Tabla[vL,tand],vL);

     //P -> OR CONJUNCION P | EPSILON
     Tabla[vP,tthen].tam:=0;
     Tabla[vP,tcorchf].tam:=0;

     insertarl(Tabla[vP,tor],tor);
     insertarl(Tabla[vP,tor],vconjuncion);
     insertarl(Tabla[vP,tor],vP);



     //COND -> EXPARIT OPREL EXPARIT | [DISYUNCION]
     insertarl(Tabla[vcond,tid],vexpAritm);
     insertarl(Tabla[vcond,tid],voprel);
     insertarl(Tabla[vcond,tid],vexpAritm);

     insertarl(Tabla[vcond,tconst],vexpAritm);
     insertarl(Tabla[vcond,tconst],voprel);
     insertarl(Tabla[vcond,tconst],vexpAritm);

     insertarl(Tabla[vcond,tcantidad],vexpAritm);
     insertarl(Tabla[vcond,tcantidad],voprel);
     insertarl(Tabla[vcond,tcantidad],vexpAritm);

     insertarl(Tabla[vcond,telemento],vexpAritm);
     insertarl(Tabla[vcond,telemento],voprel);
     insertarl(Tabla[vcond,telemento],vexpAritm);

     insertarl(Tabla[vcond,tsqrt],vexpAritm);
     insertarl(Tabla[vcond,tsqrt],voprel);
     insertarl(Tabla[vcond,tsqrt],vexpAritm);

     insertarl(Tabla[vcond,tparenti],vexpAritm);
     insertarl(Tabla[vcond,tparenti],voprel);
     insertarl(Tabla[vcond,tparenti],vexpAritm);

     insertarl(Tabla[vcond,tcorchi],tcorchi);
     insertarl(Tabla[vcond,tcorchi],vdisyuncion);
     insertarl(Tabla[vcond,tcorchi],tcorchf);


     //E -> ELSE BLOQUE | EPSILON
     insertarl(Tabla[vE,telse],telse);
     insertarl(Tabla[vE,telse],vbloque);

     Tabla[vE,tpuntoycoma].tam:=0;


     //BLOQUE -> BEGIN SENTENCIA END
     insertarl(Tabla[vbloque,tbegin],tbegin);
     insertarl(Tabla[vbloque,tbegin],vsentencia);
     insertarl(Tabla[vbloque,tbegin],tend);

    //H ->
    insertarl(Tabla[vH,tid],velementos);
    insertarl(Tabla[vH,tconst],velementos);
    insertarl(Tabla[vH,tcantidad],velementos);
    insertarl(Tabla[vH,telemento],velementos);
    insertarl(Tabla[vH,tsqrt],velementos);
    insertarl(Tabla[vH,tparenti],velementos);
    Tabla[vH,tcorchf].tam:=0;

    //MIENTRAS -> WHILE DISYUNCION THEN BLOQUE
    insertarl(Tabla[vmientras,twhile],twhile);
    insertarl(Tabla[vmientras,twhile],vdisyuncion);
    insertarl(Tabla[vmientras,twhile],tthen);
    insertarl(Tabla[vmientras,twhile],vbloque);

     //LEER -> READ(CADENA, ID)
     insertarl(Tabla[vleer,tread],tread);
     insertarl(Tabla[vleer,tread],tparenti);
     insertarl(Tabla[vleer,tread],tcadena);
     insertarl(Tabla[vleer,tread],tcoma);
     insertarl(Tabla[vleer,tread],tid);
     insertarl(Tabla[vleer,tread],tparentf);

     //ESCRIBIR -> WRITE(CADENA, EXPARIT)
     insertarl(Tabla[vescribir,twrite],twrite);
     insertarl(Tabla[vescribir,twrite],tparenti);
     insertarl(Tabla[vescribir,twrite],tcadena);
     insertarl(Tabla[vescribir,twrite],tcoma);
     insertarl(Tabla[vescribir,twrite],vexpAritm);
     insertarl(Tabla[vescribir,twrite],tparentf);

     //R -> SENT R | EPSILON
     insertarl(Tabla[vR,tid],vsent);
     insertarl(Tabla[vR,tid],vR);

     insertarl(Tabla[vR,tif],vsent);
     insertarl(Tabla[vR,tif],vR);

     insertarl(Tabla[vR,tfor],vsent);
     insertarl(Tabla[vR,tfor],vR);

     insertarl(Tabla[vR,tread],vsent);
     insertarl(Tabla[vR,tread],vR);

     insertarl(Tabla[vR,twrite],vsent);
     insertarl(Tabla[vR,twrite],vR);

     insertarl(Tabla[vR,twhile],vsent);
     insertarl(Tabla[vR,twhile],vR);

     insertarl(Tabla[vR,treemplazar],vsent);
     insertarl(Tabla[vR,treemplazar],vR);

     insertarl(Tabla[vR,tagregar],vsent);
     insertarl(Tabla[vR,tagregar],vR);

     insertarl(Tabla[vR,teliminar],vsent);
     insertarl(Tabla[vR,teliminar],vR);

     Tabla[vR,tend].tam:=0;


     //PARA -> FOR ID:_EXPARIT TO EXPARIT DO BLOQUE
     insertarl(Tabla[vpara,tfor],tfor);
     insertarl(Tabla[vpara,tfor],tid);
     insertarl(Tabla[vpara,tfor],topAsig);
     insertarl(Tabla[vpara,tfor],vexpAritm);
     insertarl(Tabla[vpara,tfor],tto);
     insertarl(Tabla[vpara,tfor],vexpAritm);
     insertarl(Tabla[vpara,tfor],tdo );
     insertarl(Tabla[vpara,tfor],vbloque);


     //S -> +TS | -TS | EPSILON
     Tabla[vS,tcorchf].tam:=0;
     Tabla[vS,tparentf].tam:=0;
     Tabla[vS,tor].tam:=0;
     Tabla[vS,tand].tam:=0;
     Tabla[vS,tdo].tam:=0;
     Tabla[vS,tto].tam:=0;
     Tabla[vS,tpuntoycoma].tam:=0;
     Tabla[vS,tcoma].tam:=0;
     Tabla[vS,tmenor].tam:=0;
     Tabla[vS,tmayor].tam:=0;
     Tabla[vS,tigual].tam:=0;
     Tabla[vS,tthen].tam:=0;
     Tabla[vS,tmenorigual].tam:=0;
     Tabla[vS,tmayorigual].tam:=0;
     Tabla[vS,tpotencia].tam:=0;

     insertarl(Tabla[vS,tmas],tmas);
     insertarl(Tabla[vS,tmas],vT);
     insertarl(Tabla[vS,tmas],vS);

     insertarl(Tabla[vS,tmenos],tmenos);
     insertarl(Tabla[vS,tmenos],vT);
     insertarl(Tabla[vS,tmenos],vS);


     //Z -> /DZ | *DZ | EPSILON
     Tabla[vZ,tcorchf].tam:=0;
     Tabla[vZ,tparentf].tam:=0;
     Tabla[vZ,tor].tam:=0;
     Tabla[vZ,tand].tam:=0;
     Tabla[vZ,tdo].tam:=0;
     Tabla[vZ,tto].tam:=0;
     Tabla[vZ,tmas].tam:=0;
     Tabla[vZ,tmenos].tam:=0;
     Tabla[vZ,tcoma].tam:=0;
     Tabla[vZ,tmenor].tam:=0;
     Tabla[vZ,tmayor].tam:=0;
     Tabla[vZ,tigual].tam:=0;
     Tabla[vZ,tthen].tam:=0;
     Tabla[vZ,tmayorigual].tam:=0;
     Tabla[vZ,tmenorigual].tam:=0;
     Tabla[vZ,tpotencia].tam:=0;
     Tabla[vZ,tpuntoycoma].tam:=0;

     insertarl(Tabla[vZ,tdividir],tdividir );
     insertarl(Tabla[vZ,tdividir],vD);
     insertarl(Tabla[vZ,tdividir],vZ);

     insertarl(Tabla[vZ,tmultiplicar],tmultiplicar );
     insertarl(Tabla[vZ,tmultiplicar],vD);
     insertarl(Tabla[vZ,tmultiplicar],vZ);


     insertarl(Tabla[vH,tparenti],velementos);



     insertarl(Tabla[vdisyuncion,tparenti],vconjuncion);
     insertarl(Tabla[vdisyuncion,tparenti],vP);


     insertarl(Tabla[vdisyuncion,tcorchi],vconjuncion);
     insertarl(Tabla[vdisyuncion,tcorchi],vP);

     insertarl(Tabla[vconjuncion,tcorchi],vnegacion);
     insertarl(Tabla[vconjuncion,tcorchi],vL);

     insertarl(Tabla[vnegacion,tcorchi],vcond);


     insertarl(Tabla[voprel,tmayor],tmayor);
     insertarl(Tabla[voprel,tmenor],tmenor);
     insertarl(Tabla[voprel,tmenorigual],tmenorigual);
     insertarl(Tabla[voprel,tmayorigual],tmayorigual);
     insertarl(Tabla[voprel,tigual],tigual);




end;


procedure analizadorsint(r : string; var raiz:tarbolderivacion; var s : boolean);
 type
  result = (procesando,exito,errorlex,errorsint);
 var
  tas1:tas;
  pilasint:tpila;
  compolex:simbolos;
  control:longint;
  lexema:string;
  ts:ttabla;
  resultado:result;
  f:archivo;
  info:tdatop;
  i:byte;
  elemento:simbolos;
  arbol:tarbolderivacion;
  hijo:tarbolderivacion;
  simbolo:simbolos;
  puntero:tarbolderivacion;
  aux1,aux2:tarbolderivacion;
  aux:tpunterop;

  //archarbol:text;


begin
creartablasim(ts);
 creartas(tas1);
 crearp(pilasint);
 info.x:=pesos;
 info.parbol:=nil;
 apilar(pilasint,info);
 info.x:=vprograma;
 crearnodo(raiz,vprograma);
 info.parbol:=raiz;
 apilar(pilasint,info);




 control:=0;
  assign(f,r);
 {$I-}
 reset(f);
 {$I+}
 if ioresult <> 0 then
 begin
  writeln('  Error De Archivo Pulse Una Tecla ');
  readkey;
 end
    else
    begin

    obtenersigcomplex(f,control,compolex,lexema,ts);

    writeln('    ',compolex,' - ',lexema);

    resultado := procesando;
        while resultado = procesando do
        begin
        eliminarp(pilasint,info);
     //   writeln('se desapilo ',info.x);
        if info.x in [tlistas..telemento] then
        begin
          if info.x=compolex then
           begin
             info.parbol^.lexema:=lexema;
            obtenersigcomplex(f,control,compolex,lexema,ts);

            //writeln('    ',compolex,' - ',lexema);


          // READLN;

           end
          else
          begin
             resultado:=errorsint;
             writeln('error sintactico: se esperaba ',info.x,' y se obtuvo: ',compolex);
             readkey;
          end;
        end
       else
       if info.x in [vPROGRAMA..vL] then
        begin
         if tas1[info.x,compolex].tam=celdavacia then
           begin
           resultado:=errorsint;
           writeln('error sintactico: desde la variable ',info.x,' no se puede llegar a: ',compolex);
           readkey;
           end
          else
           begin

         //  write('produccion: ', info.x,'-->');
           primero(tas1[info.x,compolex]);
           while not finlista(tas1[info.x,compolex]) do
            begin
              leeractual(tas1[info.x,compolex],elemento);

            //  write(elemento,' ');

              crearnodo(hijo,elemento);
              agregarhijo(info.parbol,hijo);
              siguiente(tas1[info.x,compolex]);

            end;

           aux1:=info.parbol;
           for i:= aux1^.cant downto 1 do
               begin
               aux2:=aux1^.hijos[i];
               info.x:=aux2^.simbolo;
               info.parbol:=aux2;
               apilar(pilasint,info);

               end;
           end;
        end
       else

       if (info.x=pesos) and (compolex=pesos) then
        resultado:=exito;
   end;
  if resultado=exito then
   s:=true
  else
   s:=false;
 end;
 end;


end.
