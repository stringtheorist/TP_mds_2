function [an, bn] = AmplitudeModale(L, el, kn, wn, n, H, Aff)
    an = 2 * H ./ (n * pi) .* (L / (L - el)) .* sin(kn * el) ./ (kn * el);
    bn = zeros(size(n));

    if (Aff=='o')
      %=> visualisation des amplitudes modales an
      figure(2);
      stem(wn,abs(an),'LineWidth',2)
      xlabel('wn [rad/s]')
      ylabel('|an| [m]')
      set(gca,'FontSize',24)
    end
end
