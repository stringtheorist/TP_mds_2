  duree_son = 1.2;

  if (rI=='p')
    [p,tp] = pression(P_micro,rho_air,c_son,A,kn,wn,an,bn,Y,s,t,ps,pt);
  else
    [p,tp] = pression_violon(P_micro,rho_air,c_son,A,kn,wn,Y,u,s,t,ps,pt);
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
  L = length(tpp);
  T = tpp(length(tpp))/(L-1);
  Fs = 1/T;

  t_0 = 0.5 * tpp(length(tpp)); % Milieu du "pic" de l'impulsion
  tau = 0.1 * tpp(length(tpp)); % Comment "aigu" la rendre
  gaussian = exp(-((tpp - t_0)/tau).^2);

  Niveau_sonore = 0.15/max(b);
  sound(Niveau_sonore*b,Fs);

