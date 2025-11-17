%% ========================================================================
%% INITIALISATION =========================================================
clear;close all;clc;
%% ========================================================================
% Chargement des parametres
[L,R,E,ro,Note,H,el,Nw,nmax,Aff]=ParamInit;
% Parametres intermediaires
[A,C,N0,Def]=ParamInter(R,L,ro,E,Note);
% Domaine modal
[n,kn,wn,Lamb,Per,Freq]=DomaineModal(Nw,L,C);
% Domaine spatial
[s,ds,Ns]=DomaineSpatial(L,Lamb);
% Domaine temporel
[dt,t,Nt,tmax]=DomaineTemporel(Per,L);
% Rq : dans une phase de bebeugage, il faut que [Nt,Ns,Nw] aient des valeurs 
% raisonnables (<=1000) et si possible distinctes.
disp(['[Nt,Ns,Nw]=[' num2str([Nt,Ns,Nw]) ']'])

%% ========================================================================
%% ANALYSE MODALE =========================================================
% Modes propres
Y=ModePropre(kn,s,Nw,Aff);size(Y)
% Amplitude modale
[an,bn]=AmplitudeModale(H, L, el, n, kn,wn);
% Fonction en temps
T=FctTemporelle(Nw,wn,an,bn,t);
% Deplacement
u=FctDeplacement(Y,T);

%% ========================================================================
%% VALORISATION ==========================================================
Type=1;Illustration(Type,u,s,t,Nt)
Type=2;Illustration(Type,u,s,t,Nt)
Type=3;Illustration(Type,u,s,t,Nt)
% D'autres valorisations peuvent etre envisagees, quelques propostion
% Film ?
% Son ?
% Autre ?