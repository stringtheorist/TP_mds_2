%% ============================================================================
%% INITIALISATION =========================================================
clear;close all;clc;
%% ========================================================================
% Chargement des parametres
<<<<<<< HEAD
[L,R,E,ro,Note,H,el,Nw,nmax,Aff]=ParamInit;
=======
nmax=50;        % Nombre maximal de mode considere
Note=440;       % Frequence fondamentale [Hz]
NP=5;           % Nombre de période (pour la plus grande des périodes, ie. le mode avec la plus petite fréquence) que l'on veut représenter

[L,R,E,ro,H,el,Nw,Aff]=ParamInit(nmax,Note);

>>>>>>> main
% Parametres intermediaires
[A,C,N0,Def]=ParamInter(R,L,ro,E,Note);

% Domaine modal
[n,kn,wn,Lamb,Per,Freq]=DomaineModal(L, C, nmax);

% Domaine spatial
<<<<<<< HEAD
[s,ds,Ns]=DomaineSpatial(L,Lamb);
=======
[s,Ns,ds]=DomaineSpatial(L,Lamb);

>>>>>>> main
% Domaine temporel
[dt,t,Nt,tmax]=DomaineTemporel(Per,L,NP);
% Rq : dans une phase de bebeugage, il faut que [Nt,Ns,Nw] aient des valeurs
% raisonnables (<=1000) et si possible distinctes.
disp(['[Nt,Ns,Nw]=[' num2str([Nt,Ns,Nw]) ']']);


%% ========================================================================
%% ANALYSE MODALE =========================================================
% Modes propres
<<<<<<< HEAD
Y=ModePropre(kn,s,Nw,Aff);size(Y)
% Amplitude modale
[an,bn]=AmplitudeModale(H, L, el, n, kn,wn);
% Fonction en temps
T=FctTemporelle(Nw,wn,an,bn,t);
=======
Y=ModePropre(kn,s,Nw,Aff,nmax);

% Amplitude modale
[an,bn]=AmplitudeModale(L,el,kn,wn,n,H,Aff);

% Fonction en temps
disp(nmax);
T=FctTemporelle(Nw,wn,an,bn,t,Aff);

>>>>>>> main
% Deplacement
u=FctDeplacement(Y,T);


%% ========================================================================
%% VALORISATION ==========================================================
<<<<<<< HEAD
Type=1;Illustration(Type,u,s,t,Nt)
Type=2;Illustration(Type,u,s,t,Nt)
Type=3;Illustration(Type,u,s,t,Nt)
=======
Type=1;Illustration(Type,u,s,t,Nt,L,H,dt,tmax);
Type=2;Illustration(Type,u,s,t,Nt,L,H,dt,tmax);
Type=3;Illustration(Type,u,s,t,Nt,L,H,dt,tmax);
>>>>>>> main
% D'autres valorisations peuvent etre envisagees, quelques propostion
% Film ?
% Son ?
% Autre ?
