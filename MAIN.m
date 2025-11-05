%% ============================================================================
%% INITIALISATION =========================================================
clear;close all;clc;
%% ========================================================================
% Chargement des parametres
nmax=10;        % Nombre maximal de mode considere
Note=440;       % Frequence fondamentale [Hz]
[L,R,E,ro,Note,H,el,Nw,Aff,nmax]=ParamInit(nmax,Note);

% Parametres intermediaires
[A,C,N0,Def]=ParamInter(R,L,ro,E,Note);
% Domaine modal
[n,kn,wn,Lamb,Per,Freq]=DomaineModal(L, C, nmax);
% Domaine spatial
[s,Ns,ds]=DomaineSpatial(L,Lamb);
% Domaine temporel
[dt,t,Nt,tmax]=DomaineTemporel(Per,L);
% Rq : dans une phase de bebeugage, il faut que [Nt,Ns,Nw] aient des valeurs
% raisonnables (<=1000) et si possible distinctes.
disp(['[Nt,Ns,Nw]=[' num2str([Nt,Ns,Nw]) ']'])

%% ========================================================================
%% ANALYSE MODALE =========================================================
% Modes propres
Y=ModePropre(kn,s,Nw,Aff,nmax);
% Amplitude modale
[an,bn]=AmplitudeModale(L,el,kn,wn,n,H,Aff);
% Fonction en temps
disp(nmax);
T=FctTemporelle(Nw,wn,an,bn,t,Aff);
% Deplacement
u=FctDeplacement(Y,T);

%% ========================================================================
%% VALORISATION ==========================================================
Type=1;Illustration(Type,u,s,t,Nt,L,H);
Type=2;Illustration(Type,u,s,t,Nt,L,H);
Type=3;Illustration(Type,u,s,t,Nt,L,H);
% D'autres valorisations peuvent etre envisagees, quelques propostion
% Film ?
% Son ?
% Autre ?
