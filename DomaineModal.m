

% % Domaine modal
% nmax=10;        % Nombre maximal de mode considere      
% n=(1:nmax)';    % Indices modaux
% Nw=nmax;
% kn=n*pi/L;      % Nombres d'ondes [1/m] : corde fixee aux deux extremites
% wn=C*kn;        % Pulsation [rad/s], relation de dispersion
% Lamb=2*pi./kn;  % Longueur d'onde de chaque mode [m]
% Per=2*pi./wn;   % Periode de chaque mode [s]
% Freq=1./Per;    % Frequence de chaque mode [Hz]



function [n, kn, wn, Lamb, Per, Freq] = DomaineModal(nmax,L, C)
    n = (1:nmax)';          
    kn = n * pi / L;        
    wn = C * kn;            
    Lamb = 2 * pi ./ kn;    
    Per = 2 * pi ./ wn;     
    Freq = 1 ./ Per;        
end



