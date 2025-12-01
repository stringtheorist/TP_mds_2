function [an, bn] = AmplitudeModaleViolon(L, el, kn, wn, n, H, Aff)
    an = sin(kn .* s);
    bn = zeros(size(n));

    if (Aff==1)
      %=> visualisation des amplitudes modales an pour le problème type violon
      figure(2);
      stem(wn,abs(an),'LineWidth',2)
      xlabel('wn [rad/s]')
      ylabel('|an| [m]')
      set(gca,'FontSize',24)
    end
end
