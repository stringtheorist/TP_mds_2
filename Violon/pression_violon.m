function [p,tp] = pression_violon(P_micro,rho_air,c_son,A,wn,Y,u,s,t,ps,pt) %si ps = 1 on prend tous les s et t, si pas = 2, on prend un pas sur 2

  %Re-calibrage des données pour ne pas trop en avoir et ne pas se surcharger en calcul
  sp = zeros(1,floor(length(s)/ps));
  for jp=1:1:length(sp)
    j = jp*ps;
    sp(jp) = s(j);
  end

  tp = zeros(1,floor(length(t)/pt));
  for jp=1:1:length(tp)
    j = jp*pt;
    tp(jp) = t(j);
  end

  theta = zeros(1,length(sp));
  r = zeros(length(sp));
  for j=1:1:length(sp)
    [theta(j),phi,r(j)] = cart2sph([P_micro 0]-[sp(j) 0 0]); %phi est toujours égal à 0 ici
  end

  Yp = zeros(length(wn),length(sp));
  for kp=1:1:length(sp)
    k = kp*ps;
    Yp(:,kp) = Y(:,k);
  end

  up = zeros(length(sp),length(tp));
  for kp=1:1:length(sp)
    k = kp*ps;
    for jp=1:1:length(sp)
      j = jp*pt;
      up(kp,jp) = u(k,j);
    end
  end

  %calcul de la pression sonore effectuée par un élément dx de la corde

  pn = zeros(length(wn),length(tp),length(sp));
  coeff_1 = rho_air * sqrt(A/pi) / 4*pi*c_son;

  denominateur = length(wn)*length(tp)*length(r);
  etape = 0;
  for m=1:1:length(r)
    du = gradient(up(m,:),tp);
    for l=1:1:length(tp)
      for k=1:1:length(wn)
        etape += 1;
        km = wn(k)/c_son;
        expo = exp(-i*km*r(m));
        dephasage = 1 - i/(km*r(m));
        amplitude = abs(Yp(k,m));
        pn(k,l,m) = coeff_1 * amplitude * (wn(k))^2 * du(l) * real(expo * dephasage * cos(theta(m)) / r(m));
      end
    end
    disp(['Calcul en cours... ',num2str(100*etape/denominateur),' pourcent']);
  end

  %Intégration
  disp('Intégration');
  I = zeros(1,length(tp));
  denominateur = length(wn)*length(tp)*(length(sp)-1);
  etape = 0;
  for l=1:1:length(tp)
    for k=1:1:length(wn)
      In = 0;
      for m=1:1:(length(sp)-1)
        etape += 1;
        In += (pn(k,l,m+1)-pn(k,l,m)).*sp(m);
      end
      I(l) += In;
    end
    disp(['Intégration en cours... ',num2str(100*etape/denominateur),' pourcent']);
  end

  p = I;
end
