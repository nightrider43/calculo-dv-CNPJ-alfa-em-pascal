program calculo_dv_cnpj_alfa;
uses SysUtils;
function CharToValue(c: Char): Integer;
begin
  case c of
    '0': Result := 0;
    '1': Result := 1;
    '2': Result := 2;
    '3': Result := 3;
    '4': Result := 4;
    '5': Result := 5;
    '6': Result := 6;
    '7': Result := 7;
    '8': Result := 8;
    '9': Result := 9;
    'A', 'a': Result := 17;
    'B', 'b': Result := 18;
    'C', 'c': Result := 19;
    'D', 'd': Result := 20;
    'E', 'e': Result := 21;
    'F', 'f': Result := 22;
    'G', 'g': Result := 23;
    'H', 'h': Result := 24;
    'I', 'i': Result := 25;
    'J', 'j': Result := 26;
    'K', 'k': Result := 27;
    'L', 'l': Result := 28;
    'M', 'm': Result := 29;
    'N', 'n': Result := 30;
    'O', 'o': Result := 31;
    'P', 'p': Result := 32;
    'Q', 'q': Result := 33;
    'R', 'r': Result := 34;
    'S', 's': Result := 35;
    'T', 't': Result := 36;
    'U', 'u': Result := 37;
    'V', 'v': Result := 38;
    'W', 'w': Result := 39;
    'X', 'x': Result := 40;
    'Y', 'y': Result := 41;
    'Z', 'z': Result := 42;
  else
    Result := -1; // Invalid character
  end;
end;

function calcula_dv_CNPJ_alfa (base: string) : string;

const
  peso_calculo_primeiro_digito : array [0..11] of Integer = (5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2);
  peso_calculo_segundo_digito : array [0..12] of Integer = (6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2);

var
  total, resto, i, primeirodigito, segundodigito : Integer;
  letras_convertidas : array [1..12] of integer;
  letras_convertidas_com_primeiro_digito : array [1..13] of integer;

begin
  if Length (base) <> 12 then // Entrada veio com 12 dígitos?
     begin;
       Result := 'erro';
       Exit;
     end;

  for i := 1 to 12 do
    begin;
      resto := CharToValue (base [i]);
      if resto = -1 then
         begin;
           Result := 'erro';
           Exit;
         end
      else
         letras_convertidas [i] := resto;
         letras_convertidas_com_primeiro_digito [i] := resto;
    end;

// --- Calcula primeiro dígito

  total := 0;

  for i := 0 to 11 do
    total := total + letras_convertidas [i + 1] * peso_calculo_primeiro_digito [i];

  resto := total mod 11;

  if resto < 2 then
     primeirodigito := 0
  else
     primeirodigito := 11 - resto;

// --- Calcula segundo dígito

  letras_convertidas_com_primeiro_digito [13] := primeirodigito;

  total := 0;

  for i := 0 to 12 do
    total := total + letras_convertidas_com_primeiro_digito [i + 1] *
                                               peso_calculo_segundo_digito [i];

  resto := total mod 11;

  if resto < 2 then
     segundodigito := 0
  else
     segundodigito := 11 - resto;

  Result := IntToStr (primeirodigito) + IntToStr (segundodigito)
end;

begin
  Writeln (calcula_dv_CNPJ_alfa ('12ABC34501DE')); // CNPJ no exemplo da receita
end.

