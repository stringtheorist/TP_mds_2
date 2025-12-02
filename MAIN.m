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
Note=440;       % Frequence fondamentale [Hz]
NP=5;           % Nombre de période (pour la plus grande des périodes, ie. le mode avec la plus petite fréquence) que l'on veut représenter
P_micro = [1 1]; %Position du micro
ps = 10; %Echantillonage de s pour permettre de calculer rapidement une intégrale sur [0,L]
pt = 50; %Echantillonage de t


[L,R,E,ro,H,el,Nw,Aff,rho_air,c_son,omega]=ParamInit(nmax,Note);


% Parametres intermediaires
[A,C,N0,Def]=ParamInter(R,L,ro,E,Note);

% Domaine modal
[n,kn,wn,Lamb,Per,Freq]=DomaineModal(L, C, nmax);
wn

% Domaine spatial
[s,Ns,ds]=DomaineSpatial(L,Lamb);

% Domaine temporel
[dt,t,Nt,tmax]=DomaineTemporel(Per,L,NP);
% Rq : dans une phase de bebeugage, il faut que [Nt,Ns,Nw] aient des valeurs
% raisonnables (<=1000) et si possible distinctes.
disp(['[Nt,Ns,Nw]=[' num2str([Nt,Ns,Nw]) ']']);


%% ========================================================================
%% ANALYSE MODALE =========================================================
% Modes propres
Y=ModePropre(kn,s,Nw,Aff,nmax);

%Y=ModesPropresViolon(kn,s,Nw,Aff,nmax);


% Amplitude modale
%[an,bn]=AmplitudeModale(L,el,kn,wn,n,H,Aff);

% Fonction en temps
disp(nmax);
T=FctTemporelle(wn,an,bn,t,Aff);

%q = FonctionTemporelleViolon(s,t,kn,wn,L,A,el,ro,omega,Aff);

% Deplacement
u=FctDeplacement(Y,T);

%u=FctDeplacementViolon(Y,q);

%% ========================================================================
%% VALORISATION ==========================================================
Type=1;Illustration(Type,u,s,t,Nt,L,H,dt,tmax);
Type=2;Illustration(Type,u,s,t,Nt,L,H,dt,tmax);
Type=3;Illustration(Type,u,s,t,Nt,L,H,dt,tmax);
% D'autres valorisations peuvent etre envisagees, quelques propostion
% Film ?
% Son ?
% Autre ?
