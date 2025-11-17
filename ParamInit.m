function [L,R,E,ro,Note,H,el,Nw,nmax,Aff]=ParamInit

% Geometrie : section cicrculaire
L=1;            % Longueur [m]
R=0.001;        % Rayon [m]

% Materiau : acier
E=210e9;        % Module de Young [Pa]
ro=7800;        % Masse volumique [kg/m^3]

% Tension : corde accordee sur le la-440
Note=440;       % Frequence fondamentale [Hz]

% Excitation: corde pincee d'une hauteur H en s=el 
H=L/5;          % Hauteur [m]
el=L/4;         % poistion [m]

% Domaine modal
nmax=10;        % Nombre maximal de mode considere      
Nw=nmax;

Aff = 1;
Type = [1,2,3];