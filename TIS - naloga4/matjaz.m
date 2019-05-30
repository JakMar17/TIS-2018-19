function izhod = naloga4(vhod,Fs)
% Funkcija naloga4 skusa poiskati akord v zvocnem zapisu.
%
% vhod  - vhodni zvocni zapis (vrsticni vektor tipa double) 
% Fs    - frekvenca vzorcenja
% izhod - ime akorda, ki se skriva v zvocnem zapisu (niz);
%         ce frekvence v zvocnem zapisu ne ustrezajo nobenemu
%         od navedenih akordov, vrnemo prazen niz [].
%krajsaj = mod(length(vhod),Fs);

N = length(vhod);
Fn = Fs/2 %Nyquist
amplituda = (abs((fft(vhod,N)/N))); %fft postavimo v "realno"
%frekvence = (([0:N-1]*Fs)/N); %frekvencni pas
%plot(frekvence(1:ceil(N/2)),amplituda(1:ceil(N/2))) %postavimo iz "bins" na prave frekvence

amplituda = amplituda(1:N/2); % odrežemo proc polovico
%Najdemo vrhe; Premaknemo za ena levo in desno ter primerjamo;
f1 = abs(amplituda(2:N/2-1)); %// sredina
f2 = abs(amplituda(1:N/2-2)); %// levo
f3 = abs(amplituda(3:N/2)); %// desno
idx = find(f1 > f2 & f1 > f3 & f1 > mean(amplituda))%mean(amplituda) == threshold za amplitude ki so nižje od povprecja "šum"

idx;
idx = idx*Fs; %premaknemo iz "bins" v "herz"
idx = round(idx); %zaradi napak zaokrožimo na 0 decimalk
%plot(amplituda)

%pogledamo ce imamo doloceno frekvenco
C1 = any(idx == 262) || any(idx == 261)
CIS1 = any(idx == 277) || any(idx == 278)
D1 = any(idx == 294) || any(idx == 293)
DIS1 = any(idx == 311) || any(idx == 312)
E1 = any(idx == 330) || any(idx == 329)
F1 = any(idx == 349) || any(idx == 350)
FIS1 = any(idx == 370) || any(idx == 371)
G1 = any(idx == 392) || any(idx == 393) || any(idx == 391)
GIS1 = any(idx == 416) || any(idx == 415)
A1 = any(idx == 440) || any(idx == 441) || any(idx == 339)
B1 = any(idx == 466) || any(idx == 467)
H1 = any(idx == 494) || any(idx == 493)
C2 = any(idx == 524) || any(idx == 523)
CIS2 = any(idx == 554) || any(idx == 555)
D2 = any(idx == 588) || any(idx == 587)
DIS2 = any(idx == 622) ||any(idx == 623)
FIS2 = any(idx == 740) || any(idx == 739)
E2 = any(idx == 660) || any(idx == 659)

%pogledamo ce imamo kombinacijo tonov za dolocen akord
if(C1 && E1 && G1)
  izhod = "Cdur";
elseif(C1 && DIS1 && G1)
  izhod = "Cmol";
elseif(D1 && FIS1 && A1)
  izhod = "Ddur";
elseif(D1 && F1 && A1)
  izhod = "Dmol";
elseif(E1 && GIS1 && H1)
  izhod = "Edur";
elseif(E1 && G1 && H1)
  izhod = "Emol";
elseif(F1 && A1 && C2)
  izhod = "Fdur";
elseif(F1 && GIS1 && C2)
  izhod = "Fmol";
elseif(G1 && H1 && D2)
  izhod = "Gdur";
elseif(G1 && B1 && D2)
  izhod = "Gmol";
elseif(A1 && CIS2 && E2)
  izhod = "Adur";
elseif(A1 && C2 && E2)
  izhod = "Amol";
elseif(H1 && DIS2 && FIS2)
  izhod = "Hdur";
elseif(H1 && D2 && FIS2)
  izhod = "Hmol";
else
  izhod = "";
endif  


%izhod
end