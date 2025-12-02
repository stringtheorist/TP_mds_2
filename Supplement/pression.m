function [p,tp] = pression(P_micro,rho_air,c_son,A,kn,wn,an,bn,Y,u,s,t,ps,pt) %si ps = 1 on prend tous les s et t, si pas = 2, on prend un pas sur 2

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

  pn = zeros(length(wn),length(tp),length(sp));
  coeff_1 = rho_air * sqrt(A/pi) / 4*pi*c_son;

  for k=1:1:length(wn)
    for l=1:1:length(tp)
      coeff_2 = (wn(k)^2)*(bn(k) + i.*an(k));
      for m=1:1:length(r)
        expo = exp(i*wn(k) * (tp(l) - r(m)/c_son));
        dephasage = (1 - i*c_son./(wn(k)*r(m)));
        amp = Yp(k,m)*abs(Yp(k,m));
        pn(k,l,m) = coeff_1 *amp*real(coeff_2 * expo * dephasage * cos(theta(m)) / r(m));
      end
    end
  end

  %Intégration
  I = zeros(1,length(tp));
  for l=1:1:length(tp)
    for k=1:1:length(wn)
      In = 0;
      for m=1:1:(length(sp)-1)
        In += (pn(k,l,m+1)-pn(k,l,m)).*sp(m);
      end
      I(l) += In;
    end
  end

  p = I;
end
