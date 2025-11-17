function Y = ModePropre(kn, s, Nw, Aff, nmax, typeBC)
% MODEPROPRE  Génère les modes propres Y_n(s) pour différentes C.L.
% typeBC ∈ {'DD','NN','DN','ND'}
%   DD : Dirichlet-Dirichlet
%   NN : Neumann-Neumann
%   DN : Dirichlet-Neumann
%   ND : Neumann-Dirichlet
%
% kn  : vecteur des nombres d'onde k_n
% s   : vecteur spatial
% Nw  : nombre de modes stockés
% Aff : 1 → trace quelques modes, 0 → pas de figure
% nmax: indice du dernier mode théorique (pour l'affichage, optionnel)

Y = zeros(Nw, length(s));

switch typeBC
    case 'DD'
        % Dirichlet-Dirichlet : Y_n(s) = sin(k_n s)
        for in = 1:Nw
            Y(in,:) = sin(kn(in) * s);
        end

    case 'NN'
        % Neumann-Neumann :
        %   mode 0 rigide : Y_0 = 1
        %   modes suivants : Y_n(s) = cos(k_n s)
        Y(1,:) = ones(size(s));      % mode rigide
        for in = 2:Nw               % kn(1) = k_1, etc.
            Y(in,:) = cos(kn(in-1) * s);
        end

    case 'DN'
        % Dirichlet-Neumann :
        %   Y_n(s) = sin(k_n s), avec k_n = (n+1/2)π/L
        for in = 1:Nw
            Y(in,:) = sin(kn(in) * s);
        end

    case 'ND'
        % Neumann-Dirichlet :
        %   Y_n(s) = cos(k_n s), avec k_n = (n+1/2)π/L
        for in = 1:Nw
            Y(in,:) = cos(kn(in) * s);
        end

    otherwise
        error('typeBC inconnu – choisir parmi : ''DD'', ''NN'', ''DN'', ''ND''');
end

%% Visualisation
if Aff == 1
    figure; hold on

    % on affiche les 3 premiers + le dernier mode disponible
    idx_last = min(nmax, Nw);           % évite les dépassements
    idx_plot = unique([1:min(3, Nw), idx_last]);

    plot(s, Y(idx_plot, :), 'LineWidth', 2)
    xlabel('s [m]')
    leg = arrayfun(@(k) sprintf('n = %d', k), idx_plot, 'UniformOutput', false);
    legend(leg, 'Location', 'best')
    title(['Modes propres (' typeBC ')'])
    set(gca, 'FontSize', 18)
end
end
