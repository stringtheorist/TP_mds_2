function T = FctTemporelle(w, wn, an, bn, t, Aff)
  nmax=length(wn);
  T=zeros(nmax, length(t));

  for in=1:nmax
      % T_ij, avec i=>n et j=>t
      T(in,:)=an(in)*cos(wn(in)*t)+bn(in)*sin(wn(in)*t)/wn(in);
  end

  if (Aff==1)
    %=> visualisation de T(t) pour quelques modes
    figure(3);
    plot(t,T([1:3 nmax],:),'LineWidth',2)
    xlabel('t [s]')
    legend('n=1','n=2','n=3','n=nmax')
    set(gca,'FontSize',24)
  end
end
