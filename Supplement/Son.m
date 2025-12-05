%%------------------------------------------------------------------------------------------------
%% Questions

 disp(' ');
  disp('Donner la position du micro');
  P_micro(1) = input('x = ');
  while (1)
    P_micro(2) = input('y = ');
    if (P_micro(2)!=0)
      break
    end
    disp('y doit être différent de 0.');
  end

  duree_son = 1.2;
  disp(' ');
  rep = input('Durée pour le son (en s.) : ');
  if (length(rep)!=0)
    duree_son = rep;
  end

  rep = input('Voulez vous afficher le graphique de la pression acoustique p(t) ? (o/n) ','s');

%%------------------------------------------------------------------------------------------------

  if (rI=='p')
    [p,tp] = pression(P_micro,rho_air,c_son,A,wn,an,bn,Y,s,t,ps,pt);
  else
    [p,tp] = pression_violon(P_micro,rho_air,c_son,A,wn,Y,u,s,t,ps,pt);
  end

  if (rep=='o')
    figure(6);
    plot(tp,p);
    xlabel('t [s]'); ylabel('p(t) [N/m²]');
  end

  N = floor(duree_son/max(tp));
  tpp = zeros(1,length(tp)*N);
  for k=1:1:length(tp)
    tpp(k) = tp(k);
  end

  for j=2:1:N
    for k=1:1:length(tp)
      tpp((j-1)*length(tp)+k)=tp(k)+tpp((j-1)*length(tp));
    end
  end

  b = repmat(p,1,N);
  T = duree_son/(length(tpp)-1);
  Fs = 1/T;

  Niveau_sonore = 0.15/max(b);
  sound(Niveau_sonore*b,Fs);

