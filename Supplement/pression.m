function p = pression(Pmicro,rho_air,c_air,A,kn,wn,Y,u,s)
  S = zeros(
  [theta,phi,r] = cart2sph([P 0]-[s 0 0]); %phi est toujours égal à 0 ici, donc e
  Du=derive(Y,an,bn,wn,t);

  pn = ((wn.^2)*rho_air.*sqrt(A/pi)./(r.*4*pi*c_son)).*cos(theta).*(bn+i.*an).*exp(i.*(wn.*(t-r./c_son))).*(1+c_son/(wn.*r));
  pn = partie_reele(pn);

