% Fonction en temps
function T = FctTemporelle(nmax,wn,an, bn, t)
nmax=length(wn);
T=zeros(nmax, length(t));

for in=1:nmax
    % T_ij, avec i=>n et j=>t
    T(in,:)=an(in)*cos(wn(in)*t)+bn(in)*sin(wn(in)*t)/wn(in); 
end

%=> visualisation de T(t) pour quelques modes
figure(3);
plot(t,T([1:3 nmax],:),'LineWidth',2)
xlabel('t [s]')
legend('n=1','n=2','n=3','n=nmax')
title("Fonctions en temps")
set(gca,'FontSize',24)
end