disp(' ');
while (1)
  rep = input('Voulez vous afficher le diagramme de directivité ? (o/n) ','s');
  if ismember(rep,['o' 'n'])
    break
  end
  disp('y doit être différent de 0.');
end

if (rep=='o')

  milieu = L/2;
  Rayon = milieu + 0.5;

  Micro =  [];
  phi = [];
  n_point = 50;
  for k=0:1:(n_point-1)
    Point = [Rayon*cos(2*pi*k/n_point)+milieu Rayon*sin(2*pi*k/n_point)];
    [Angle,x,y] = cart2sph([Point-[L/2 0] 0]);
    Micro = [Micro; Point];
    phi = [phi Angle];
  end


  decibel = [];
  ps = 10;
  pt = 50;
  if (rI=='p')
    for k=1:1:n_point
      disp('-----------------------------------------------------------------------------------------------'
      disp(['POURCENTAGE DE POINTS ANALYSES = ' num2str((k-1)/n_point)' pourcent']);
      [p,tp] = pression(Micro(k,:),rho_air,c_son,A,wn,an,bn,Y,s,t,ps,pt);
      p_rms = rms(p);
      deci = 20*log(p_rms/(2*10^(-5)));
      decibel = [decibel deci];
    end
  else
    for k=1:1:n_point
      disp('-----------------------------------------------------------------------------------------------'
      disp(['POURCENTAGE DE POINTS ANALYSES = ',num2str((k-1)/n_point),' pourcent']);
      [p,tp] = pression_violon(Micro(k,:),rho_air,c_son,A,wn,Y,u,s,t,ps,pt);
      p_rms = rms(p);
      deci = 20*log(p_rms/(2*10^(-5)));
      decibel = [decibel deci];
    end
  end

  polarplot(phi,deci);
  title('Diagramme de rayonnement');
end
