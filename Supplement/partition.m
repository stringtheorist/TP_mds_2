function partition(Partition, Rythme, Nom_note, rep)
    % Initialisation des lignes de la portée
    C0 = [' '; '-'];
    for k = 1:4
        C0 = [C0; ' '];
        C0 = [C0; '-'];
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

            if (m == numero_note)
                if strcmp(note_jouee, 'S')
                    C = [C; 'S'];
                else
                    C = [C; 'O'];
                end

            else
                C = [C; C0(m, :)];
            end
        end

        % Assurez-vous que C, D0, et C0 sont des colonnes
        if strcmp(note_jouee, 'do')
            tab = [tab, D0, C, D0, C0];
        else
            tab = [tab, C, C0, C0];
        end

    end

    tab = [tab, C0, C0, C0];

    % Affichage
    for m = 1:size(tab, 1)
        disp(tab(m, :));
    end
end

