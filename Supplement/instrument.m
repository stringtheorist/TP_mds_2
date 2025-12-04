%% ============================================================================
%% INITIALISATION =========================================================
clear;close all;clc;

addpath('./Fct');
addpath('./Initialisation');
addpath('./Mode');
addpath('./Supplement');
addpath('./Violon');

%% ============================================================================
%% Choix de l'instrument =========================================================

disp('Violon = v et Guitare = g');
while (1)
  rep = input('De quelle ibstrument voulez vous jouer ? ,'s');
  if ((rep=='v')||(rep=='g'))
    break
  end
  disp('Les réponses acceptables sont v ou g');
end


disp(' ');
  disp('Donner la position du micro');
  P_micro(1) = input('x = ');
  while (1)
    P_micro(2) = input('y = ');
    if (P_micro(2)!=0)
      break
    end
    disp('y doit être différent de 0.');
  end

%% ========================================================================
% Chargement des parametres

nmax=50;        % Nombre maximal de mode considere
Note_I =   [261.626  293.665   329.628    349.228   391.995   440    493.883];       % Note à partir du do de l'octave "3" : https://fr.wikipedia.org/wiki/Fr%C3%A9quences_des_touches_du_piano
Nom_note = ['do'    're'        'mi'        'fa'      'sol'   'la'     'si'];
NP=5;           % Nombre de période (pour la plus grande des périodes, ie. le mode avec la plus petite fréquence) que l'on veut représenter
P_micro = [1 1]; %Position du micro
ps = 10; %Echantillonage de s pour permettre de calculer rapidement une intégrale sur [0,L]
pt = 50; %Echantillonage de t
Pt = zeros(length(Note_I),);
Pp = zeros(length(Note_I));

for k=1:1:length(Note_I)
  Note = Note_I(k);
  [L,R,E,ro,H,el,Nw,Aff,rho_air,c_son,omega]=ParamInit(nmax);

  % Parametres intermediaires
  [A,C,N0,Def]=ParamInter(R,L,ro,E,Note);

  % Domaine modal
  [n,kn,wn,Lamb,Per,Freq]=DomaineModal(L, C, nmax);

  % Domaine spatial
  [s,Ns,ds]=DomaineSpatial(L,Lamb);

  % Domaine temporel
  [dt,t,Nt,tmax]=DomaineTemporel(Per,L,NP);

  %% ========================================================================
  %% ANALYSE MODALE =========================================================

  if (rI=='p')
    % Modes propres
    Y=ModePropre(kn,s,Nw,Aff,nmax);

    % Amplitude modale
    [an,bn]=AmplitudeModale(L,el,kn,wn,n,H,Aff);

    % Fonction en temps
    T=FctTemporelle(wn,an,bn,t,Aff);

    % Deplacement
    u=FctDeplacement(Y,T);
  else
    % Modes propres
    Y=ModesPropresViolon(kn,s,Nw,Aff,nmax);

    % Fonction en temps
    q = FonctionTemporelleViolon(s,t,kn,wn,L,A,el,ro,omega,Aff);

    % Deplacement
    u=FctDeplacementViolon(Y,q);

  end
  if (instrument=='g')
    [p,tp] = pression(P_micro,rho_air,c_son,A,wn,an,bn,Y,s,t,ps,pt);
  else
    [p,tp] = pression_violon(P_micro,rho_air,c_son,A,wn,Y,u,s,t,ps,pt);
  end
  Pt(k,:) = tp;
  Pp(k,:) = p;
end

%Param = wn; an; bn; ; Y; u; t;
disp(' ');
tempo = input('Saisisez le tempo (nb de notes/min): ');
rep = input('Voulez vous jouer autre choses que des noirs ? (o/n) ','s');
duree_son pour noir = 60/tempo;
if (rep=='o')

else
  disp("Indiquer les notes que vous voulez jouer en indiquant la note puis si c'est une croche (c), noire (n), blanche (b) ou une ronde (r).");
end
