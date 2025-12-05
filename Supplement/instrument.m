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

rep = input('Voulez vous composer un morceau ? (o/n) ','s');

if (rep=='o')

  disp('Violon = v et Guitare = g');
  while (1)
    rI = input('De quelle instrument voulez vous jouer ? ','s');
    if ((rI=='v')||(rI=='g'))
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
  Nom_note = ['do';   're';        'mi';      'fa';    'sol';   'la';     'si'];
  NP=5;           % Nombre de période (pour la plus grande des périodes, ie. le mode avec la plus petite fréquence) que l'on veut représenter
  P_micro = [1 1]; %Position du micro
  ps = 10; %Echantillonage de s pour permettre de calculer rapidement une intégrale sur [0,L]
  pt = 50; %Echantillonage de t
  %length(t) est toujours égal à  NP*20*nmax+1 quelque soit la note choisie
  Pt = zeros(length(Note_I), floor((NP*20*nmax+1)/pt)); %length(tp)=floor(length(t)/pt)
  Pp = zeros(length(Note_I), floor((NP*20*nmax+1)/pt));

  [L,R,E,ro,H,el,Nw,Aff,rho_air,c_son,omega]=ParamInit(nmax);
  for k=1:1:length(Note_I)
    Note = Note_I(k);
    disp(' ');
    disp(['Calcul du son de la note : ',Nom_note(k,:)]);
    disp('---------------------------------------------');

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

    if (rI=='g')
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
    if (rI=='g')
      [p,tp] = pression(P_micro,rho_air,c_son,A,wn,an,bn,Y,s,t,ps,pt);
    else
      [p,tp] = pression_violon(P_micro,rho_air,c_son,A,wn,Y,u,s,t,ps,pt);
    end
    Pt(k,:) = tp;
    Pp(k,:) = p;
  end


  %Composer la partition
  while (1)
    disp(' ');
    tempo = input('Saisisez le tempo (nb de notes/min): ');
    rep = input('Voulez vous jouer autre choses que des noirs ? (o/n) ','s');
    duree_noir = 60/tempo;
    Duree = [duree_noir/2; duree_noir; 2*duree_noir; 4*duree_noir];
    Nom_duree = ['c'; 'n'; 'b'; 'r'];
    if (rep=='o')
      Partition = [];
      rythme = [];
      k = 1;
      disp("Indiquer les notes que vous voulez jouer en indiquant la note puis si c'est une croche (c), noire (n), blanche (b) ou une ronde (r).");
      disp(' ');
      disp('Fin de partition = appuyer sur ENTRER');
      Note_tapee = input(['Note ',num2str(k),' : '],'s');
      Partition = [Note_tapee];
      rythme_tapee = input(['rythme ',num2str(k++),' : '],'s');
      rythme = [rythme_tapee];
      disp(' ');

      while (1)
        Note_tapee = input(['Note ',num2str(k),' : '],'s');
        if (length(Note_tapee)==0)
          break
        end
        rythme_tapee = input(['rythme ',num2str(k++),' : '],'s');
        if (length(rythme_tapee)==0)
          break
        end
        Partition = [Partition; Note_tapee];
        rythme = [rythme; rythme_tapee];
        disp(' ');
      end

      disp(' ');
      disp('Début du morceau');

      for k=1:1:length(Partition)
        note_jouee = Partition(k,:);
        rythme_joue = rythme(k,:);

        numero_note=1;
        while (1)
          if (note_jouee==strtrim(Nom_note(numero_note,:)))
            break
          end
          numero_note++;
        end

        numero_rythme=1;
        while (1)
          if (rythme_joue==strtrim(Nom_duree(numero_rythme,:)))
            break
          end
          numero_rythme++;
        end

        duree_note = Duree(numero_rythme);
        p = Pp(numero_note,:);
        tp = Pt(numero_note,:);

        N = floor(duree_note/max(tp));
        son_note = repmat(p,1,N);

        T = duree_note/(length(tp)*N-1);
        Fs = 1/T;
        disp(note_joue);
        sound(son_note,Fs);
      end




    else
      k = 1;
      disp("Indiquer les notes que vous voulez jouer en indiquant la note (do re mi fa sol la si).");
      disp(' ');
      disp('Fin de partition = appuyer sur ENTRER');
      Note_tapee = input(['Note ',num2str(k++),' : '],'s');
      Partition = [Note_tapee];

      while (1)
        Note_tapee = input(['Note ',num2str(k++),' : '],'s');
        if (length(Note_tapee)==0)
          break
        end
        Partition = [Partition; Note_tapee];
      end

      disp(' ');
      disp('Début du morceau');

      for k=1:1:length(Partition)
        note_jouee = Partition(k,:);

        numero_note=1;
        while (1)
          if (note_jouee==strtrim(Nom_note(numero_note,:)))
            break
          end
          numero_note++;
        end

        p = Pp(numero_note,:);
        tp = Pt(numero_note,:);

        N = floor(duree_noir/max(tp));
        son_note = repmat(p,1,N);

        T = duree_noir/(length(tp)*N-1);
        Fs = 1/T;
        disp(note_jouee);
        sound(son_note,Fs);
      end
    end
    rep = input('Voulez vous jouer un autre morceau ? (o/n) ','s');
    if (rep=='n')
      break
    end
  end
end
