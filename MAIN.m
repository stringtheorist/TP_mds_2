%% ============================================================================
%% INITIALISATION =========================================================
clear;close all;clc;

addpath('./Fct');
addpath('./Initialisation');
addpath('./Mode');
addpath('./Supplement');
addpath('./Violon');


%% ========================================================================
% Chargement des parametres
nmax=50;        % Nombre maximal de mode considere
Note=540;       % Frequence fondamentale [Hz]
NP=5;           % Nombre de période (pour la plus grande des périodes, ie. le mode avec la plus petite fréquence) que l'on veut représenter
P_micro = [1 1]; %Position du micro
ps = 10; %Echantillonage de s pour permettre de calculer rapidement une intégrale sur [0,L]
pt = 50; %Echantillonage de t

[L,R,E,ro,H,el,Nw,Aff,rho_air,c_son,omega]=ParamInit(nmax);


% Parametres intermediaires
[A,C,N0,Def]=ParamInter(R,L,ro,E,Note);

% Domaine modal
[n,kn,wn,Lamb,Per,Freq]=DomaineModal(L, C, nmax);


% Domaine spatial
[s,Ns,ds]=DomaineSpatial(L,Lamb);

% Domaine temporel
[dt,t,Nt,tmax]=DomaineTemporel(Per,L,NP);
% Rq : dans une phase de debugage, il faut que [Nt,Ns,Nw] aient des valeurs
% raisonnables (<=1000) et si possible distinctes.
disp(['[Nt,Ns,Nw]=[' num2str([Nt,Ns,Nw]) ']']);


%% ========================================================================
%% ANALYSE MODALE =========================================================

while (1)
  rI = input('Voulez vous simuler un violon (v) ou une corde pincée (p) ? ','s' );
  if ((rI=='v')||(rI=='p'))
    break
  end
  disp('Les réponses acceptables sont : v ou p');
end

if (rI=='p')
  % Modes propres
  Aff = input('Voulez vous afficher quelques modes propres ? (o/n) ','s');
  Y=ModePropre(kn,s,Nw,Aff,nmax);

  % Amplitude modale
  Aff = input('Voulez vous visualiser des amplitudes modales an ? (o/n) ','s');
  [an,bn]=AmplitudeModale(L,el,kn,wn,n,H,Aff);

  % Fonction en temps
  Aff = input('Voulez vous visualiser T(t) pour quelque modes ? (o/n) ','s');
  T=FctTemporelle(wn,an,bn,t,Aff);

  % Deplacement
  u=FctDeplacement(Y,T);
else
  % Modes propres
  Aff = input('Voulez vous visualiser quelques modes propres ? (o/n) ','s');
  Y=ModesPropresViolon(kn,s,Nw,Aff,nmax);

  % Fonction en temps
  Aff = input('Voulez vous visualiser q(t) pour quelques modes ? (o/n) ','s');
  q = FonctionTemporelleViolon(s,t,kn,wn,L,A,el,ro,omega,Aff);

  % Deplacement
  u=FctDeplacementViolon(Y,q);

end

%% ========================================================================
%% VALORISATION ==========================================================

Type = [];
while (1)
  r=input('Voulez vous visualiser u(s,t) a divers instant ? (o/n) ','s');
  if (r=='o')
    Type = [1];
    break
  elseif (r=='n')
    break
  end
  disp("La réponse donné doit être : 'o' ou 'n'");
end

while (1)
  r=input('Voulez vous visualiser u(s,t) en divers points de la corde ? (o/n) ','s');
  if (r=='o')
    Type = [Type 2];
    break
  elseif (r=='n')
    break
  end
  disp("La réponse donné doit être : 'o' ou 'n'");
end

while (1)
  r=input('Voulez vous afficher la corde en mouvement ? (o/n) ','s');
  if (r=='o')
    Type = [Type 3];
    break
  elseif (r=='n')
    break
  end
  disp("La réponse donné doit être : 'o' ou 'n'");
end

Illustration(Type,u,s,t,Nt,L,H,dt,tmax);



while (1)
  r=input('Voulez vous produire le son associé ? (o/n) ','s');
  if (r=='o')
    Son
    break
  elseif (r=='n')
    break
  end
  disp("La réponse donné doit être : 'o' ou 'n'");
end

% Autre ?
