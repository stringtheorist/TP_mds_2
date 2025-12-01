function q = FonctionTemporelleViolon(s,t,kn,wn,el,ro,omega)

    nmax=length(wn);
    q=zeros(nmax, length(t));

    q = 2/(ro*A*L) * ( sins(el*kn)./wn ) .* ( ( wn.*sin(omega*t) .- omega*sin(wn.*t) )/( wn.^2 - omega^2 );

    if (Aff==1)
     %=> visualisation de q(t) pour quelques modes
     figure(3);
     plot(t,q([1:3 nmax],:),'LineWidth',2)
     xlabel('t [s]')
     legend('n=1','n=2','n=3','n=nmax')
     set(gca,'FontSize',24)
  end

 end
