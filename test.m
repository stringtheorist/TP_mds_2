% Quelques constantes
Fs = 44.1e3; % Fréquence d'échantillonnage : 44.1 KHz
F_tone = 440; % Ton de 440 Hz
L = 4; % 4 secondes


% Générer le vecteur "temps"
t = 0:(1/Fs):L;


% Générer les données sonores

% Prendre une onde sinusoïdale :
y1 = cos(2*pi*F_tone*t);

% Faire une impulsion gaussienne (pour démarrer et arrêter l'onde en douceur)
t_0 = 0.5 * L; % Milieu du "pic" de l'impulsion
tau = 0.1 * L; % Comment "aigu" la rendre
gaussian = exp(-((t - t_0)/tau).^2);

% Calculer l'onde entière = y1 * gaussian
y = y1 .* gaussian;

% Baisser le son
% (C'est super fort à plein volume)
y = y * 0.4;

% Tracer la forme d'onde
plot(t, y)
xlabel('Temps (s)')
ylabel('Amplitude')


% Jouer le son
sound(y, Fs)
