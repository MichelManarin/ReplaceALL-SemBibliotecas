unit uSubstitui;

interface

uses
  uISubstitui;

type

  TSubstitui = class(TInterfacedObject, ISubstitui)
  public
    function Substituir(aStr, aVelho, aNovo: String): String;
  end;

implementation


{ Testes realizados.:
  ShowMessage(Substituir('12332112312321123321512332132023','123','321'));
  ShowMessage(Substituir('Palestina','lestina','ris'));
  ShowMessage(Substituir('O rato roeu a roupa do rei de roma','ro','teste'));
}

function TSubstitui.Substituir(aStr, aVelho, aNovo: String): String;
var
  qteAcrescimo,
  caracterFound,
  idxposicao,
  salvaPosicao: integer;

  // Retorna a posição da primeira equivalencia que encontrar.
  // Se retornar 0 não existe equivalencia.
  function Pos(acumIndex:Boolean):integer;
  var
    i:integer;
  begin
    result := 0;
    caracterFound := 0;

    for i := idxposicao to Length(aStr) do
    begin
      if aStr[i] = aVelho[caracterFound+1] then
        caracterFound := caracterFound+1
      else
        begin
          // Ainda assim temos que comparar com o primeiro caracter no aVelho
          caracterFound := 0;

          if aStr[i] = aVelho[1] then
            caracterFound := 1
          else
            caracterFound := 0;
        end;

      if caracterFound = Length(aVelho) then
      begin
        if (acumIndex) then
          idxposicao := i;

        result := i;
        exit;
      end;
    end;
  end;

  // Acrescenta caract na string original
  function Acresc(Posicao,Qtde:integer):String;
  var
    i:integer;
  begin
    result := '';

    for i := 1 to Posicao do
      result := result + aStr[i];

    for i := 1 to Qtde do
      result := result + '#';

    for i := posicao+1 to Length(aStr) do
      result := result + aStr[i];
  end;

  // Decrementa caract na string original
  procedure Descr(Posicao,Qtde:integer);
  var
    i:integer;
  begin
    result := '';

    for i := posicao downto (posicao - Abs(qtde)+1) do
      aStr[i] := ' ';

  end;

  // Controla contadores
  procedure Reset();
  begin
    caracterFound := 0;
  end;

  // Substitui e retorna a nova string
  procedure Replace(index:integer);
  var
    i,aux:integer;
  begin
    aux := 0;
    for i := index to ((index -1)+ Length(aNovo)) do
    begin
      aux := aux + 1;
      aStr[i] := aNovo[aux];
    end;
  end;

begin
  idxposicao := 1;
  qteAcrescimo := Length(aNovo) - Length(aVelho);
   { A função POS não é a da biblioteca, ela está implementada mais acima...}
  while (Pos(False) > 0) do
  begin

     if qteAcrescimo > 0 then
      aStr := Acresc(Pos(False),qteAcrescimo);

     salvaPosicao := Pos(True);

     Replace(salvaPosicao-Length(aVelho)+1);

     if qteAcrescimo < 0 then
      Descr(salvaposicao,qteAcrescimo);

     idxposicao := idxposicao+qteAcrescimo+1;
  end;

  Result := aStr;
end;
  
end.

