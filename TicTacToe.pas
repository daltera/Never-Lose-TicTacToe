program TicTacToe;

const
	space = ' ';

type
	arrIn = array [1..9] of integer;
	arrMov = array [1..5] of integer;
	arrChar = array [1..9] of char;
	arrSol = array [1..3] of integer;
	arrFin = array [1..8] of array [1..3] of integer;
	

procedure readFin(var a:text; var b:arrFin);

var
	c,i,j:integer;
begin
	reset(a);	
	while not eof(a) do
	begin
	
		for i:=1 to 8 do
		begin
			for j:=1 to 3 do
			begin
				read(a,c);
				b[i][j]:=c;
			end;
		end;
	end;
	close(a);
	
end;
	
procedure start(var a:arrIn; var b:arrIn; var c:arrMov; var d:arrMov; var e: arrChar; var isWin:boolean);

var
	i:integer;

begin
	for i:=1 to 9 do
	begin
		a[i] := i;
	end;
	
	for i:=1 to 9 do
	begin
		b[i] := 0;
	end;
	
	for i:=1 to 5 do
	begin
		c[i] := 0;
	end;
	
	for i:=1 to 5 do
	begin
		d[i] := 0;
	end;
	
	for i:=1 to 9 do
	begin
		e[i]:= space;
	end;
	
	isWin := false;
end;

procedure printBoard(a:arrChar);

var
	i:integer;

begin
	i:=1;
	while  (i < 9) do
		begin
			writeln(a[i],'|',a[i+1],'|',a[i+2]);
			i:=i+3;
		end;
end;

function SearchB(a:integer; b:arrIn):boolean;

var
	i:integer;
	c:boolean;
	
begin
	c := false;
	i:= 1;
	while (not(c) and (i <= length(b))) do
	begin
		if ((a = b[i]) and (a <> 0)) then
		begin
			c:=true;
		end
		else
		begin
			i:=i+1;
		end;
	end;
	SearchB := c;
end;

function SearchB1(a:integer; b:arrSol):boolean;

var
	i:integer;
	c:boolean;
	
begin
	c := false;
	i:=1;
	while ((not(c)) and (i <= length(b))) do
	begin
		if (a = b[i]) then
		begin
			c:=true;
		end
		else
		begin
			i:=i+1;
		end;
	end;
	SearchB1 := c;
end;

function SearchIndex(a:integer; b:arrIn):integer;

var
	i,c:integer;
	d:boolean;
	
begin
	d := false;
	c := -1;
	i:= 1;
	while ((not(d)) and (i <= length(b))) do
	begin
		if (a = b[i]) then
		begin
			d:=true;
			c:=i;
		end
		else
		begin
			i:=i+1;
		end;
	end;
	SearchIndex := c;
end;

function SearchIndex1(a:integer; b:arrMov):integer;

var
	i,c:integer;
	d:boolean;
	
begin
	d := false;
	c := -1;
	i:= 1;
	while ((not(d)) and (i <= length(b))) do
	begin
		if (a = b[i]) then
		begin
			d:=true;
			c:=i;
		end
		else
		begin
			i:=i+1;
		end;
	end;
	SearchIndex1 := c;
end;

procedure DelEl(x:integer; var a:arrIn);

begin
		a[SearchIndex(x,a)] := 0;
end;	

procedure AddChar(a:integer; c:integer; var b:arrChar);

begin
	if (a = 1) then
	begin
		b[c]:= 'X';
	end
	else
	begin
		b[c] := 'O';
	end;
end;
		

procedure AddEl(x:integer; j:integer; var a:arrIn; var b:arrMov; var c:arrChar; var d:arrIn);

begin
	if (SearchB(x,a)) then
	begin
		b[SearchIndex1(0,b)]:= x;
		d[SearchIndex(0,d)]:= x;
		AddChar(j,x,c);
		DelEl(x,a);
	end
	else
	begin
		writeln('Invalid Move');
	end;
end;

function MatchInt(a:arrMov; b:arrSol):boolean;

var
	i:integer;
	sum:integer;
	
begin
	sum:=0;
	for i:=1 to length(a) do
	begin
		if (SearchB1(a[i],b)) then
		begin
		sum := sum+1;
		end;
	end;
	if (sum = 3) then
	begin
		MatchInt:=true;
	end
	else
	begin
		MatchInt := false;
	end;
	
end;

function MatchArrWin(a:arrMov; b: arrFin):boolean;

var
	i,j:integer;
	d:arrSol;
	e:boolean;
	

begin
	e := false;
	i:=1;
	j:=1;
		while ((i <= 8) and not(e)) do
		begin
			while ((j<= 3) and not(e)) do
			begin
				d[j] := b[i][j];
				j:=j+1;
			end;
			if (MatchInt(a,d)) then
			begin
				e:=true;
			end
			else
			begin
				i:=i+1;
				j:=1;
			end;
		end;	
		MatchArrWin:= e;
end;

function nbElmtSama(a:arrMov; b:arrSol):integer;

var
	i,j:integer;
	sum:integer;

begin
	sum:=0;
	
	for i:= 1 to length(a) do
	begin
		for j:=1 to length(b) do
		begin
			if (a[i] = b[j]) then
			begin
				sum:=sum+1;
			end;
		end;
	end;
	
	nbElmtSama := sum;

end;


procedure computerMove(var initial,log:arrIn; var cp,hp:arrMov;  solns:arrFin; var state:arrChar);

var
	i,match,temp,primus,j,k,temp1,match1,primus1:integer;
	s:arrSol;
	moveDone:boolean;
	found:boolean;
	e:arrFin;
	

begin
e:=solns;
moveDone:=false;
primus:=1;
primus1:=1;
while (not(moveDone)) do
begin
	match := -1;
	match1:= -1;
	temp1:= 0;
	temp := 0;
	for i:= 1 to 8 do
	begin
		for j:=1 to 3 do
		begin
			s[j]:=e[i][j]
		end;
		temp:=nbElmtSama(hp,s);
		if (temp >= match) then
		begin
			match:=temp;
			primus:=i;
		end;
		temp1:= nbElmtSama(cp,s);
		if (temp1 >= match1) then
		begin
			match1:=temp1;
			primus1:=i;
		end;
	
		
	end;
	
	if (match1 >= match)then
	begin
		primus:=primus1;
	end;
	j:=1;
		while (j <= 3) do
		begin
			if (SearchB((e[primus][j]),initial)) then
			begin
				AddEl((e[primus][j]),0,initial,cp,state,log);
				writeln(e[primus][j]);
				moveDone:=true;
				j:=1;
				break;
			end
			else
			begin
				j:=j+1;
			end;
		end;
		
		if (j > 3) then
		begin
			for j:=1 to 3 do
			begin
				e[primus][j]:= -1;
			end;
		end;
		
		primus :=1;
		primus1:=1;
		
end;
	
end;

procedure computerMove1(isFirst:boolean; var initial,log:arrIn; var cp,hp:arrMov;  solns:arrFin; var state:arrChar);

var
	i,match,temp,primus,j,k,temp1,match1,primus1:integer;
	s:arrSol;
	moveDone:boolean;
	found:boolean;
	e:arrFin;
	

begin
e:=solns;
moveDone:=false;
primus:=1;
primus1:=1;
while (not(moveDone)) do
begin
	match := -1;
	match1:= -1;
	temp1:= 0;
	temp := 0;
	for i:= 1 to 8 do
	begin
		for j:=1 to 3 do
		begin
			s[j]:=e[i][j]
		end;
		temp:=nbElmtSama(hp,s);
		if (temp >= match) then
		begin
			match:=temp;
			primus:=i;
		end;
		temp1:= nbElmtSama(cp,s);
		if (temp1 >= match1) then
		begin
			match1:=temp1;
			primus1:=i;
		end;
	
		
	end;
	
	if ((match1 >= match) and (not(isFirst)))then
	begin
		primus:=primus1;
	end;
	j:=1;
		while (j <= 3) do
		begin
			if (SearchB((e[primus][j]),initial)) then
			begin
				AddEl((e[primus][j]),1,initial,cp,state,log);
				writeln(e[primus][j]);
				moveDone:=true;
				j:=1;
				break;
			end
			else
			begin
				j:=j+1;
			end;
		end;
		
		if (j > 3) then
		begin
			for j:=1 to 3 do
			begin
				e[primus][j]:= -1;
			end;
		end;
		
		primus :=1;
		primus1:=1;
		
end;
	
end;

function isAllZero(a:arrIn):boolean;

var
	i:integer;
	b:boolean;
begin
	b:=true;
	i:=1;
	while ((b) and (i<= length(a)))  do
	begin
		if (a[i] <> 0) then
		begin
			b:=false;
		end
		else
		begin
			i:=i+1;
		end;
	end;
	isAllZero:=b;
end;



procedure main(isFirst:boolean; solus:arrFin; var a,b:arrIn; var c,d:arrMov; var e: arrChar; var isWin:boolean; var winner:integer);

var
	f:integer;

begin
	if (isFirst) then 
	begin
		if (isWin = false) then
		begin
			computerMove(a,b,d,c,solus,e);
			printBoard(e);
			if (MatchArrWin(d,solus)) then
			begin
				isWin:= true;
				winner := 2;
			end
			else
			begin
				if (isAllZero(a)) then
				begin
					isWin:=true;
					winner:=3;
				end;
			end;
		end;
		
		if (isWin = false) then
		begin
			readln(f);
			while ((SearchB(f,a)) <> true) do
			begin
				writeln('Invalid move');
				readln(f);
			end;
			AddEl(f,1,a,c,e,b);
			printBoard(e);
			if (MatchArrWin(c,solus)) then
			begin
				isWin:= true;
				winner := 1;
			end
			else
			begin
				if (isAllZero(a)) then
				begin
					isWin:=true;
					winner:=3;
				end;
			end;
			
		end;
	end
	else
	begin
		if (isWin = false) then
		begin
			readln(f);
			while ((SearchB(f,a)) <> true) do
			begin
				writeln('Invalid move');
				readln(f);
			end;
			AddEl(f,1,a,c,e,b);
			printBoard(e);
			if (MatchArrWin(c,solus)) then
			begin
				isWin:= true;
				winner := 1;
			end
			else
			begin
				if (isAllZero(a)) then
				begin
					isWin:=true;
					winner:=3;
				end;
			end;
			
		end;
		
		if (isWin = false) then
		begin
			computerMove(a,b,d,c,solus,e);
			printBoard(e);
			if (MatchArrWin(d,solus)) then
			begin
				isWin:= true;
				winner := 2;
			end
			else
			begin
				if (isAllZero(a)) then
				begin
					isWin:=true;
					winner:=3;
				end;
			end;
		end;
		
		
	
	end;
		
		
end;

{procedure maintest(isFirst:boolean; solus:arrFin; var a,b:arrIn; var c,d:arrMov; var e: arrChar; var isWin:boolean; var winner:integer);

var
	f:integer;

begin
	if (isFirst) then 
	begin
		if (isWin = false) then
		begin
			computerMove(a,b,d,c,solus,e);
			printBoard(e);
			if (MatchArrWin(d,solus)) then
			begin
				isWin:= true;
				winner := 2;
			end
			else
			begin
				if (isAllZero(a)) then
				begin
					isWin:=true;
					winner:=3;
				end;
			end;
		end;
		
		if (isWin = false) then
		begin
			computerMove1(a,b,c,d,solus,e);
			printBoard(e);
			if (MatchArrWin(c,solus)) then
			begin
				isWin:= true;
				winner := 1;
			end
			else
			begin
				if (isAllZero(a)) then
				begin
					isWin:=true;
					winner:=3;
				end;
			end;
			
		end;
	end
	else
	begin
		if (isWin = false) then
		begin
			computerMove1(a,b,c,d,solus,e);
			printBoard(e);
			if (MatchArrWin(c,solus)) then
			begin
				isWin:= true;
				winner := 1;
			end
			else
			begin
				if (isAllZero(a)) then
				begin
					isWin:=true;
					winner:=3;
				end;
			end;
			
		end;
		
		if (isWin = false) then
		begin
			computerMove(a,b,d,c,solus,e);
			printBoard(e);
			if (MatchArrWin(d,solus)) then
			begin
				isWin:= true;
				winner := 2;
			end
			else
			begin
				if (isAllZero(a)) then
				begin
					isWin:=true;
					winner:=3;
				end;
			end;
		end;
		
		
	
	end;
		
		
end;
}
var
	a,b:arrIn;
	hp,cp:arrMov;
	e:arrChar;
	fin:arrFin;
	dokum:text;
	f,winner:integer;
	win,isFirst:boolean;
	p:arrSol;
	i,j:integer;
	stet:text;


begin
	assign(dokum,'statefinal.txt');
	assign(stet,'states.txt');
	append(stet);
	readFin(dokum,fin);
	writeln(stet,'');
	winner:=0;
	start(a,b,hp,cp,e,win);
	writeln('Masukan giliran permainan:');
	f:=0;
	while ((f <> 1) and (f <> 2)) do
	begin
		readln(f);
		if ((f <> 1) and (f <> 2)) then
		begin
		writeln('Masukan salah');
		end;
	end;

	if (f = 1) then
		begin
			AddEl(5,1,a,hp,e,b);
			isFirst:= true;
			writeln(e[1]);
		end
		else
		begin
			if (f = 2) then
			begin
				AddEl(5,0,a,cp,e,b);
				isFirst:= false;
				printBoard(e);
			end;
		end;
	while (not(win)) do
	begin
		main(isFirst,fin,a,b,hp,cp,e,win,winner);
	end;
	
	if (winner = 1) then
	begin
		writeln('Impossible');
	end
	else
	begin
		if (winner = 2) then
		begin
			writeln('Expected');
		end
		else
		begin
			writeln('Nice try');
		end;
	end;
	
	if ((winner = 2) or (winner=3)) then
	begin
	for i:=1 to 9 do
	begin
		write(b[i]);
	end;
	end;
	close(stet);
end.

			