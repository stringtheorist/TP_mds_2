function Y=ModePropre(kn,s,Nw,Aff,nmax)
  % Modes propres
  Y = sin(kn.*s);

  Aff = input('Voulez vous afficher quelques modes propres ? (o/n) ','s');
  if (Aff=='o')
    %=> visualisation de quelques modes propres
    figure(1);
    plot(s,Y([1:3 nmax],:),'LineWidth',2)
    xlabel('s [m]')
    ylabel('Yn(s)')
    legend('n=1','n=2','n=3','n=nmax')
    set(gca,'FontSize',24)
  end
end
