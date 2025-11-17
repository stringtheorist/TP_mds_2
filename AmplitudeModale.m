
function [an, bn] = AmplitudeModale(H, L, el, n, kn,wn)
    an = 2 * H ./ (n * pi) .* (L / (L - el)) .* sin(kn * el) ./ (kn * el);
    bn = zeros(size(n));


%=> visualisation des amplitudes modales an
figure(2);
stem(wn,abs(an),'LineWidth',2)
xlabel('wn [rad/s]')
ylabel('|an| [m]')
set(gca,'FontSize',24)