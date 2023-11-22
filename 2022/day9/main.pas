program Aoc2022Day9;

const
  touchesWidth = 1000;
  touchesHeight = 1000;

type
  PosArray = array[0..1] of Integer;

var
  dataFile: TextFile;
  row: string;
  posHead, posTail: PosArray;
  touches: array[0..touchesHeight, 0..touchesWidth] of Boolean;
  i, j, currentNumber, code: Integer;
  strNumber: string;

procedure InitalizeArrays();
begin
  for i:= 0 to 1 do
  begin
    posHead[i] := Round(touchesWidth / 3);
    posTail[i] := Round(touchesHeight / 3);
  end;

  for i:= 0 to touchesHeight do
    for j:= 0 to touchesWidth do
      touches[i, j] := false;
end;

procedure PrintTouches();
var
  count: Integer;
begin
  count := 0;

  for i:= 0 to touchesHeight do
  begin
    for j:= 0 to touchesWidth do
      if (j = Round(touchesHeight / 3)) and (i = Round(touchesHeight / 3)) then
      begin
        count += 1;
      end
      else
      begin
        if touches[j, i] = true then
        begin
          count += 1;
        end
      end;

  end;

  WriteLn('Partone Count: ', count);
end;

procedure UpdateTail(lastHead: PosArray);
begin

  if (Abs(posHead[0] - posTail[0]) > 1) or (Abs(posHead[1] - posTail[1]) > 1) then
  begin
    posTail[0] := lastHead[0];
    posTail[1] := lastHead[1];
  end;

  touches[posTail[0], posTail[1]] := true;
end;

procedure MoveHorizontal(direction, amount: Integer);
var
  lastHead: PosArray;
begin
  for i:=0 to amount - 1 do
  begin
    lastHead[0] := posHead[0];
    lastHead[1] := posHead[1];
    posHead[0] := posHead[0] + direction;
    UpdateTail(lastHead);
  end;
end;

procedure MoveVertical(direction, amount: Integer);
var
  lastHead: PosArray;
begin
  for i:=0 to amount - 1do
  begin
    lastHead[0] := posHead[0];
    lastHead[1] := posHead[1];
    posHead[1] := posHead[1] + direction;
    UpdateTail(lastHead);
  end;
end;

begin
  InitalizeArrays();

  // Create file reader
  Assign(dataFile, 'data');
  Reset(dataFile);

  // Read file line by line
  while not Eof(dataFile) do
  begin
    ReadLn(dataFile, row);
    strNumber := copy(row, 3, Length(row));
    Val(strNumber, currentNumber, code);

    case (row[1]) of
      'R': MoveHorizontal(1, currentNumber);
      'L': MoveHorizontal(-1, currentNumber);
      'U': MoveVertical(1, currentNumber);
      'D': MoveVertical(-1, currentNumber);
    end;
  end;

  Close(dataFile);
  PrintTouches();
end.