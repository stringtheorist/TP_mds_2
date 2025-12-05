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
