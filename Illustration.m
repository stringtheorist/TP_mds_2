<<<<<<< HEAD
function Illustration(Type,u,s,t,Nt)
=======
function Illustration(Type,u,s,t,Nt,L,H,dt,tmax)
>>>>>>> main

for i = 1:length(Type)

    if (Type(i) == 1)
      %-> visualisation de u(s,t) a divers instants
       figure(4);%subplot(1,2,1)
       plot(s,u(:,[1 10 20]),'LineWidth',2);
       xlabel('s [m]');ylabel('u(s,t) [m]')
       legend(['t=' num2str(t(1)) ],['t=' num2str(t(10)) ],['t=' num2str(t(20)) ])
       %axis equal
       set(gca,'FontSize',24)

<<<<<<< HEAD
    elseif (Type(i) == 2)    
=======
    elseif (Type(i) == 2)
>>>>>>> main
      %-> visualisation de u(s,t) en divers point de la corde
       figure(5);%subplot(1,2,2)
       plot(t,u([1 10 20],:),'LineWidth',2);
       xlabel('t [m]');ylabel('u(s,t) [m]');
       legend(['s=' num2str(s(1)) ],['s=' num2str(s(10)) ],['s=' num2str(s(20)) ])
       set(gca,'FontSize',24)

    else
        %-> visualisation de u(s,t) au cours du temps
<<<<<<< HEAD
       figure(6);
    
=======
       figure(5);

>>>>>>> main
       for j=1:Nt
           plot(s,u(:,j),'k','LineWidth',2);hold on
           plot(s([1 10 20]),u([1 10 20],j),'o','MarkerSize',8,'LineWidth',2)
           hold off
           xlabel('s [m]');ylabel('u(s,t) [m]');
<<<<<<< HEAD
           %axis equal;axis([0,L,-H,H])
=======
           axis equal;axis([0,L,-H,H])
           title(['temps = ',num2str(t(j)),' s.',newline,'Fin = ',num2str(tmax),' s.']);
>>>>>>> main
           set(gca,'FontSize',24);
           pause(dt)
       end

    end

end
