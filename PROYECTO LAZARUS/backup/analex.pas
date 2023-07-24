unit analex;

interface
uses declaraciones,crt;
const
 finarchivo=#0;

procedure obtenersigcomplex(var fuente:archivo; var control:longint; var compolex:simbolos; var lexema:string; ts:ttabla);


implementation

procedure leerCar(var fuente:archivo;var control:longint;var car:char);
begin
if control<filesize(fuente) then
 begin
  seek(fuente,control);
  read(fuente,car);
 end
else
begin
car:=finarchivo;
end;


end;


Function EsId(Var Fuente:Archivo;Var Control:Longint;Var Lexema:String):Boolean;
Const
  q0=0;
  F=[3];
Type
  Q=0..3;
  Sigma=(Letra, Digito, Otro);
  TipoDelta=Array[Q,Sigma] of Q;
Var
  EstadoActual:Q;
  Delta:TipoDelta;
  P:Longint;
  Car:char;

   Function CarASimb(Car:Char):Sigma;
Begin
  Case Car of
    'a'..'z', 'A'..'Z':CarASimb:=Letra;
    '0'..'9'	     :CarASimb:=Digito;
  else
   CarASimb:=Otro;
  End;
End;

Begin
  {Cargar la tabla de transiciones}
  Delta[0,Letra]:=1;
  Delta[0,Digito]:=2;
  Delta[0,Otro]:=2;
  Delta[1,Digito]:=1;
  Delta[1,Letra]:=1;
  Delta[1,Otro]:=3;


  {Recorrer la cadena de entrada y cambiar estados}
  EstadoActual:=q0;
P:=Control;
Lexema:= '';
While EstadoActual in [0..1] do
begin
     LeerCar(Fuente,P,Car);
     EstadoActual:=Delta[EstadoActual,CarASimb(Car)];
     P:=P+1;
     If EstadoActual = 1 then
          Lexema:= Lexema + car;

end;
     If EstadoActual in F then
          Control:= P-1;
     EsId:= EstadoActual in F
end;

Function EsConstReal(Var Fuente:Archivo;Var Control:Longint;Var Lexema:String):Boolean;
Const
  q0=0;
  F=[4];
Type
  Q=0..5;
  Sigma=(Digito, coma , Otro);
  TipoDelta=Array[Q,Sigma] of Q;
Var
  P: Longint;
  Car: Char;
  EstadoActual:Q;
  Delta:TipoDelta;

   Function CarASimb(Car:Char):Sigma;
Begin
  Case Car of
       '0'..'9':CarASimb:=Digito;
       '.' : CarASimb:=Coma;
  else
   CarASimb:= Otro;
  End;
End;

Begin
  {Cargar la tabla de transiciones}

  Delta[0,Coma]:=3;
  Delta[0,Digito]:=1;
  Delta[0,Otro]:=3;

  Delta[1,Coma]:=2;
  Delta[1,Digito]:=1;
  Delta[1,Otro]:=4;

  Delta[2,Coma]:=3;
  Delta[2,Digito]:=5;
  Delta[2,Otro]:=3;

  Delta[5,Coma]:=3;
  Delta[5,Digito]:=5;
  Delta[5,Otro]:=4;


  {Recorrer la cadena de entrada y cambiar estados}
  EstadoActual:=q0;
P:=Control;
Lexema:= '';
While EstadoActual in [0,1,2,5] do
begin
     LeerCar(Fuente,P,Car);
     EstadoActual:=Delta[EstadoActual,CarASimb(Car)];
     P:=P+1;
     If EstadoActual in [0,1,2,5] then
          Lexema:= Lexema + car;
end;
     If EstadoActual in F then
          Control:= P-1;
     EsConstReal:= EstadoActual in F
end;
Function EsConstCadena(Var Fuente: Archivo ; Var Control: Longint ; Var Lexema: String): Boolean;
Const
     q0=0;
     F=[4];
Type
    Q=0..4;
    Sigma=(Letra, Digito, comilla ,  Otro);
    TipoDelta=Array[Q,Sigma] of Q;
Var
   EstadoActual:Q;
   Delta:TipoDelta;
   P: Longint;
   Car: Char;
   anterior:Q;
                                                {ARREGLAR FORMULANDO LOS AUTOMATAS}
   Function CarASimb(car:char):Sigma;
   begin

     Case Car of
       'a'..'z', 'A'..'Z':CarASimb:=Letra;
       '0'..'9':CarASimb:=Digito;
       '"' : CarASimb:= comilla;
     else
      CarASimb:=Otro;
     end;
     end;
Begin
{Cargar la tabla de transiciones}
    Delta[0,Letra]:=2;
    Delta[0,Digito]:=2;
    Delta[0,Otro]:=2;
    Delta[0,comilla]:=1;

    Delta[1,Letra]:=1;
    Delta[1,Digito]:=1;
    Delta[1,Comilla]:=3;
    Delta[1,Otro]:=1;

    Delta[3,Letra]:=2;
    Delta[3,Digito]:=2;
    Delta[3,Otro]:=4;
    Delta[3,Comilla]:=2;

{Recorrer la cadena de entrada y cambiar estados}
EstadoActual:=q0;
P:=Control;
Lexema:= '';
anterior:=q0;
While EstadoActual in [0,1,3] do
begin

     LeerCar(Fuente,P,Car);
     EstadoActual:=Delta[EstadoActual,CarASimb(Car)];
     P:=P+1;
     If EstadoActual in [0,1,3] then
          Lexema:= Lexema + car;

end;
If EstadoActual in F then
begin
     Control:= P;
end;
EsConstCadena:=EstadoActual in F;

end;
Function EssimboloEspecial(Var Fuente:archivo;Var Control:Longint; var compolex:simbolos; Var Lexema:String):Boolean;         //Transformación de un Autómata Finito Determinístico en un programa de reconocedor
var
   car:char;
begin

leercar(fuente,control,car);
if car in ['=',',','(',')','[',']',';','>','<','+','-','*','/','^','&','~','|',':'] then
begin
essimboloespecial:=true;
case car of
  ':':begin inc(control);
            leercar(fuente,control,car);
            if car = '_' then
            begin
                 lexema:=':_';
                 compolex:=topAsig;
                 inc(control);
            end
            else
            begin
            lexema:=':';
            compolex:=tdospuntos;
            end;
      end;
  '=': begin
             compolex:=tigual;
             inc(control);
             end;
  ';':begin
        inc(control);
        lexema:=';';
        compolex:=tpuntoycoma;
        end;

  ',': begin
             compolex:=tcoma;
             inc(control);
             end;
  '(': begin
             compolex:=tparenti;
             inc(control);
             end;
  ')': begin
             compolex:= tparentf;
             inc(control);
             end;
  '>': begin inc(control);
            leercar(fuente,control,car);
            if car = '=' then
            begin
                 lexema:='>=';
                 compolex:=tmayorigual;
                 inc(control);
            end
            else
            begin
            lexema:='>';
            compolex:=tmayor;
            end;
      end;
  '<': begin inc(control);
            leercar(fuente,control,car);
            if car = '=' then
            begin
                 lexema:='<=';
                 compolex:=tmenorigual;
                 inc(control);
            end
            else
            begin
            lexema:='<';
            compolex:=tmenor;
            end;
      end;
  '+': begin
             compolex:= tmas;
             inc(control);
             end;
  '-': begin
             compolex:= tmenos;
             inc(control);
             end;
  '*': begin
             compolex:=tmultiplicar;
             inc(control);
             end;
  '/': begin
             compolex:=tdividir;
             inc(control);
             end;
  '^': begin
             compolex:=tpotencia;
             inc(control);
             end;
  '&': begin
             compolex:=tand;
             inc(control);
             end;
  '~': begin
             compolex:=tnot;
             inc(control);
             end;
  '|': begin
             compolex:=tor;
             inc(control);
             end;
  '[': begin
             compolex:=tcorchi;
             inc(control);
             end;
  ']': begin
             compolex:=tcorchf;
             inc(control);
             end;
  end;
end
else
 essimboloespecial:=false;


end;

procedure obtenersigcomplex(var fuente:archivo; var control:longint; var compolex:simbolos; var lexema:string; ts:ttabla);

var
caracter:char;


begin
  leercar(fuente,control,caracter);
     while caracter in [#1..#32] do
      begin
       inc(control);
       leercar(fuente,control,caracter);
      end;

     if caracter=finarchivo then
     begin
     compolex:=pesos
     end
        else
            begin
            if esid(fuente,control,lexema) then
              begin
              busqentabla(ts,lexema,compolex);

              end
               else
                   begin
                   if EsConstReal(fuente,control,lexema) then
                   begin
                   compolex:=tconst;

                   end
                      else
                      if esconstcadena(fuente,control,lexema) then
                      begin
                      CompoLex:=tcadena;

                      end
                                       else if not EsSimboloEspecial(Fuente,Control,compolex,Lexema) then
                                       begin
                                       CompoLex:=Error;
                                       writeln('no es nada');
                                       readkey;
                                       end;
                   end;
            end;
end;


END.












