function T = FctTemporelle(wn, an, bn, t, Aff)
  nmax=length(wn);
  T=zeros(nmax, length(t));

  T = an.*cos(wn.*t)+bn.*sin(wn.*t)./wn;

  if (Aff=='o')
    %=> visualisation de T(t) pour quelques modes
    figure(3);
    plot(t,T([1:3 nmax],:),'LineWidth',2)
    xlabel('t [s]')
    legend('n=1','n=2','n=3','n=nmax')
    set(gca,'FontSize',24)
  end
end
