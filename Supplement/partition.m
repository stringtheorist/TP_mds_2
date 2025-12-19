<<<<<<< HEAD
function partition(Partition, Rythme, Nom_note, rep)
    % Initialisation des lignes de la portée
    C0 = [' '; '-'];
    for k = 1:4
        C0 = [C0; ' '];
        C0 = [C0; '-'];
=======
function partition(Partition,Rythme,Nom_note,rep)
  C0 = [' '; '-'];
  for k=1:1:4
    C0 = [C0; ' '];
    C0 = [C0; '-'];
  end
  C0 = [C0; ' '; ' '];
  tab = [C0];

  D0 = [' '; '-'];
  for k=1:1:4
    D0 = [D0; ' '];
    D0 = [D0; '-'];
  end
  D0 = [D0; ' '; '-'];

  %% RECUPERATION DE LA NOTE
  note_jouee_avant = ' ';
  numero_note_avant = 0;
  for k=1:1:length(Partition)
    if (rep=='o')
      rythme_jouee = strtrim(Rythme(k));
    else
      rythme_jouee = ' ';
    end
    note_jouee = strtrim(Partition(k));
    numero_note = 1;
    while (1)
      if strcmp(note_jouee,strtrim(Nom_note(numero_note)))
        break
      end
      numero_note = numero_note + 1;
>>>>>>> c950bb789b94c2b178f2ab4a1ef9129b69b375db
    end
    C0 = [C0; ' '; ' '];

    D0 = [' '; '-'];
    for k = 1:4
        D0 = [D0; ' '];
        D0 = [D0; '-'];
    end
    D0 = [D0; ' '; '-'];

    % Initialisation de tab comme une matrice vide de caractères
    tab = C0;

    % Récupération de la note
    note_jouee_avant = ' ';
    numero_note_avant = 0;

    for k = 1:length(Partition)
        if rep == 'o'
            rythme_jouee = strtrim(Rythme(k));
        else
            rythme_jouee = ' ';
        end
        note_jouee = strtrim(Partition(k));

        % Trouver le numéro de la note
        numero_note = 1;
        while true
            if strcmp(note_jouee, strtrim(Nom_note{numero_note}))
                break;
            end
            numero_note = numero_note + 1;
        end

        % Écriture de la note
        numero_note = 13 - numero_note;
        C = [rythme_jouee; '-'];

        for m = 3:length(C0)
            if (m == numero_note) || ((m == numero_note_avant) && strcmp(note_jouee_avant, 'do'))
                if strcmp(note_jouee, 'S') && ~(m == numero_note_avant)
                    C = [C; 'S'];
                else
                    if strcmp(note_jouee_avant, 'do') && (m == numero_note_avant)
                        C = [C; ' '];
                    else
                        if strcmp(note_jouee, 'do')
                            C = [C; 'O'];
                        else
                            C = [C; 'O'];
                        end
                    end
                end
            else
                C = [C; C0(m, :)];
            end
        end

        % Assurez-vous que C, D0, et C0 sont des colonnes
        if strcmp(note_jouee, 'do')
            tab = [tab, C, D0, C0];
        else
            tab = [tab, C, C0, C0];
        end

        note_jouee_avant = note_jouee;
        numero_note_avant = numero_note;
    end

    tab = [tab, C0, C0, C0];

    % Affichage
    for m = 1:size(tab, 1)
        disp(tab(m, :));
    end
end
