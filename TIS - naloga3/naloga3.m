function [izhod, crc] = naloga3(vhod, n, k)
  % Izvedemo dekodiranje binarnega niza vhod, ki je bilo
  % zakodirano s Hammingovim kodom H(n,k)
  % in poslano po zasumljenem kanalu.
  % Nad vhodom izracunamo vrednost crc po standardu CRC-16.
  %
  % vhod  - binarni vektor y (vrstica tipa double)
  % n     - stevilo bitov v kodni zamenjavi
  % k     - stevilo podatkovnih bitov v kodni zamenjavi
  % crc   - crc vrednost izracunana po CRC-16 
  %         nad vhodnim vektorjem (sestnajstisko)
  % izhod - vektor podatkovnih bitov, dekodiranih iz vhoda
  

    

  % CRC
  vhod;
  gx = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
  size(gx);
  velikost = size(vhod, 2)
  %tmp = gx(16)
  
  for i = 1:velikost
    pm = xor(gx(16), vhod(i));
    p5 = xor(gx(5), pm);
    p12 = xor(gx(12), pm);
    
    gx = circshift(gx, 1, 2);
    
    gx(1) = pm;
    gx(6) = p5;
    gx(13) = p12;
    gx;
  end
  gx;
  
  obrnjena = (1:16);
  %obrnjena = obrni(obrnjena,size(obrnjena,2), 1);
  obrnjena = circshift(obrnjena,1,2);
  velikost = size(gx,2);
  for i = 1:velikost
    obrnjena(i) = gx(velikost+1-i);
  end
  obrnjena = int2str(obrnjena);
  obrnjena = bin2dec(obrnjena);
  obrnjena = dec2hex(obrnjena);
  
  izhod=1;
  crc = obrnjena;
end

function [out] = obrni (tabela, n, d)
  for i = 2:d+1
    out=obrniZaEna(tabela,n);
  endfor
  out=tabela;
endfunction

function [out] = obrniZaEna (tabela,n)
  temp = tabela(1);
  for i = 2:n-1
    tabela(i) = tabela(i+1);
  endfor
  tabela(n) = temp;
  out = tabela;
endfunction