function p = pression(Pmicro,rho_air,c_air,A,k,wn,Y,u,s)
  [theta,phi,r] = cart2sph([P 0]-[s 0 0]);
  p = w.^2*rho_air*sqrt(A/pi)*derive(u)

