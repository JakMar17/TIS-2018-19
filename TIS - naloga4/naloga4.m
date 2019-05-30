function izhod = naloga4(vhod,Fs)
% Funkcija naloga4 skusa poiskati akord v zvocnem zapisu.
%
% vhod  - vhodni zvocni zapis (vrsticni vektor tipa double) 
% Fs    - frekvenca vzorcenja
% izhod - ime akorda, ki se skriva v zvocnem zapisu (niz);
%         ce frekvence v zvocnem zapisu ne ustrezajo nobenemu
%         od navedenih akordov, vrnemo prazen niz [].

%akordi v vektorju v obliki
length(vhod)
vsiToni = ["C1", "CIS1", "D1", "DIS1", "E1", "F1", "FIS1", "G1", "GIS1", "A1", "B1", "H1", "C2"
          , "CIS2", "D2", "DIS2", "E2", "F2", "FIS2", "G2", "GIS2", "A2", "B2", "H2"];
stTonov = 24;
akord = zeros(1, stTonov);

Cdur = zeros(1,stTonov); Cdur(1) = 1; Cdur(5) = 1; Cdur(8) = 1;
Cmol = zeros(1,stTonov); Cmol(1) = 1; Cmol(4) = 1; Cmol(8) = 1;
Ddur = zeros(1,stTonov); Ddur(3) = 1; Ddur(7) = 1; Ddur(10) = 1;
Dmol = zeros(1,stTonov); Dmol(3) = 1; Dmol(6) = 1; Dmol(10) = 1;

Edur = zeros(1,stTonov); 
Edur(5) = 1; 
Edur(9) = 1; 
Edur(12) = 1;
Emol = zeros(1,stTonov); 
Emol(5) = 1; 
Emol(8) = 1; 
Emol(12) = 1;

Fdur = zeros(1,stTonov); 
Fdur(6) = 1; 
Fdur(10) = 1; 
Fdur(13) = 1;
Fmol = zeros(1,stTonov); 
Fmol(6) = 1; 
Fmol(9) = 1; 
Fmol(13) = 1;

Gdur = zeros(1,stTonov); 
Gdur(8) = 1; 
Gdur(12) = 1; 
Gdur(15) = 1;
Gmol = zeros(1,stTonov); 
Gmol(8) = 1; 
Gmol(11) = 1; 
Gmol(15) = 1;

Adur = zeros(1,stTonov); 
Adur(10) = 1; 
Adur(14) = 1; 
Adur(17) = 1;
Amol = zeros(1,stTonov); 
Amol(10) = 1; 
Amol(13) = 1; 
Amol(17) = 1;

Hdur = zeros(1,stTonov); 
Hdur(12) = 1; 
Hdur(16) = 1; 
Hdur(19) = 1;
Hmol = zeros(1,stTonov); 
Hmol(12) = 1; 
Hmol(15) = 1; 
Hmol(19) = 1;


amplituda = abs(fft(vhod, length(vhod))/length(vhod));

stPodatkov = length(vhod);
%a = [];
%for i = 1:(stPodatkov/2)
%  a = [a amplituda(i)];
%endfor
%amplituda = a;

amplituda = amplituda(1:(length(vhod)/2));


%levo = [];
%for i = 1:((length(vhod))/2)-2
%  levo = [levo amplituda(i)];
%endfor
%levo = abs(levo);
levo = abs(amplituda(1:length(vhod)/2-2));

%sredina = [];
%for i = 2:length(vhod)/2-1
%  sredina = [sredina amplituda(i)];
%endfor
%sredina = abs(sredina);
sredina = abs(amplituda(2:length(vhod)/2-1));

%desno = [];
%for i = 3:length(vhod)/2
%  desno = [desno amplituda(i)];
%endfor
%desno = (abs)desno;
desno = abs(amplituda(3:length(vhod)/2));

%odstrani sum
aSredina = mean(amplituda);
toni = find(sredina > levo & sredina > desno & sredina > aSredina);
length(vhod);
toni = toni * Fs / length(vhod);
toni = round(toni);

plot(amplituda)
%C1
if(any(toni == 261) || any(toni == 262))
  akord(1,1) = 1;
endif

%CIS1
if(any(toni == 277) || any(toni == 278))
  akord(2) = 1;
endif

%D1
if(any(toni == 293) || any(toni == 294))
  akord(3) = 1;
endif

%DIS1
if(any(toni == 311) || any(toni == 312))
  akord(4) = 1;
endif

%E1
if(any(toni == 329) || any(toni == 330))
  akord(5) = 1;
endif

%F1
if(any(toni == 349) || any(toni == 350))
  akord(6) = 1;
endif

%FIS1
if(any(toni == 370) || any(toni == 371))
  akord(7) = 1;
endif

%G1
if(any(toni == 391) || any(toni == 392) || any(toni == 393))
  akord(8) = 1;
endif

%GIS1
if(any(toni == 415) || any(toni == 416))
  akord(9) = 1;
endif

%A1
if(any(toni == 339) || any(toni == 440) || any(toni == 441))
  akord(10) = 1;
endif

%B1
if(any(toni == 466) || any(toni == 467))
  akord(11) = 1;
endif

%H1
if(any(toni == 493) || any(toni == 494))
  akord(12) = 1;
endif

%C2
if(any(toni == 523) || any(toni == 524))
  akord(13) = 1;
endif

%CIS2
if(any(toni == 554) || any(toni == 555))
  akord(14) = 1;
endif

%D2
if(any(toni == 587) || any(toni == 588))
  akord(15) = 1;
endif

%DIS2
if(any(toni == 622) || any(toni == 623))
  akord(16) = 1;
endif

%E2
if(any(toni == 659) || any(toni == 660))
  akord(17) = 1;
endif

%FIS2
if(any(toni == 739) || any(toni == 740))
  akord(19) = 1;
endif

akord

if (isequal(akord&Cdur, Cdur))
  Cdur
  izhod = "Cdur";
elseif (isequal(akord&Cmol, Cmol))
  Cmol
  izhod = "Cmol";
elseif (isequal(akord&Ddur, Ddur))
  Ddur
  izhod = "Ddur";
elseif (isequal(akord&Dmol, Dmol))
  Dmol
  izhod = "Dmol";
elseif (isequal(akord&Edur, Edur))
  Edur
  izhod = "Edur";
elseif (isequal(akord&Emol, Emol))
  Emol
  izhod = "Emol";
elseif (isequal(akord&Fdur, Fdur))
  Fdur
  izhod = "Fdur";
elseif (isequal(akord&Fmol, Fmol))
  Fmol
  izhod = "Fmol";
elseif (isequal(akord&Gdur, Gdur))
  Gdur
  izhod = "Gdur";
elseif (isequal(akord&Gmol, Gmol))
  Gmol
  izhod = "Gmol";
elseif (isequal(akord&Adur, Adur))
  Adur
  izhod = "Adur";
elseif (isequal(akord&Amol, Amol))
  Amol
  izhod = "Amol";
elseif (isequal(akord&Hdur, Hdur))
  Hdur
  izhod = "Hdur";
elseif (isequal(akord&Hmol, Hmol))
  Hmol
  izhod = "Hmol";
else
  izhod = "";
endif
izhod