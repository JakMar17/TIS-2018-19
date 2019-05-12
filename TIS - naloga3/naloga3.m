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
  
  stPaketov = size(vhod,2)/n;
  m = n -k;
  %H = zeros(m, n)
  H = [];
  leksiografski = [];
  identiteta = eye(m);
  stId = 1;
  
  stolpec = zeros(m,1);
  st = 1;
  id = 0;
  stEnic = 0;
  %st = dec2bin(st);
  for i = 1:n
    stolpec = zeros(m,1);
    st = dec2bin(st);
    st; 
    l = length(st);
    for j = 1:m
      if (length(st) >= j && st(l) == "1")
        stevka = 1;
        stEnic++;
      else
        stevka = 0;
      endif
      stolpec(j) = stevka;
      l--;
    endfor
    stolpec;
    st = bin2dec(st);
    st++;
    H = horzcat(H, stolpec);
    if (stEnic != 1)
      leksiografski = horzcat(leksiografski, stolpec);
    endif
    stEnic = 0;
  endfor
  H;
  leksiografski = horzcat(leksiografski, eye(m));

  if (stPaketov > 1)
    y = reshape(vhod, n, stPaketov);
    y = y';
  else
    y = vhod;
  endif
  
  s = y*leksiografski';
  for i = 1:stPaketov
    tmp = s(i:i, 1:end);
    s(i:i, 1:end) = mod(tmp, 2);
  endfor

  %if (s != 0)
  %  for i = 1:stPaketov
  %    sindrom = s(i:i, 1:end)';
  %    vektorNapake = zeros(1, n);
  %    for j = 1:n
  %      stolpec = leksiografski(1:end, j:j);
  %      if (stolpec == sindrom)
  %        vektorNapake(j) = 1;
  %        y(i:i, 1:end) = xor(y(i:i, 1:end), vektorNapake);
  %      endif
  %    endfor
  %  endfor
  %        %y(i:i, 1:end) xor (y(i:i, 1:end), 
  %  izhod = y (1:end, 1:k)';
  %else
  %  izhod = y(1:end, 1:k);
  %endif
  
  %for i = 1:stPaketov
  %  for j=1:n
  %    stolpec = leksiografski(1:end, j:j);
  %    sindrom = s(i:i, 1:end)';
  %    if (stolpec == sindrom)
  %      vektorNapake = repmat([false], 1, n);
  %      e(j) = true;
  %      y (i:i, 1:end) = xor (y(i:i, 1:end), e);
  %    endif
  %  endfor
  %endfor

  %if (s != 0)
    for i=1:stPaketov
      sindrom = s(i:i,1:end)';
      vektorNapake = zeros(1,n);
      for j=1:n
        stolpec = leksiografski(1:end, j:j);
        if(sindrom == stolpec)
          vektorNapake(j) = 1;
        endif
      endfor
      y(i:i,1:end) = xor(y(i:i,1:end),vektorNapake);
    endfor
  %endif

  izhod = y(1:end, 1:k)';

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
  
  %izhod=1;
  crc = obrnjena
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