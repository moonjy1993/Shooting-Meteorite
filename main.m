clear all     //Clear stored values from the last time

clf

N = 3     //Total of 3 bodies

G = 1     //Gravitational constant is 1

dt = 2 * pi /100    //Each time step is pi/50

tmax = 5 * pi    //The end time is 5pi

clockmax = ceil(tmax / dt)   //Finding out how many times steps there are for the 

     //program.

Ms = 1     //Mass of the sun, earth, and meteorite

Me = 0.1

Mm = 100

DES = 1     //Distance between bodies

DME = 0.1

M = [Ms; Me; Mm]   //An array of the masses

X = [0; 0; (DES + DME) * -10]  //Initial location of each bodies

Y = zeros(3,1)

Z = [0; DES; 0]

U = [0; 0; 3]    //Initial velocity of each bodies. Used arbitrary values for 

     //the meteorite's velocity in order to simulate the meteor

     //to go through and by the earth and sun.

V = [0; sqrt(G * Ms / DES); sqrt(G * Ms / DES) + sqrt(G * Me / DME) - 3]

W = [0; 0; 0]

momentum = Ms * V(1) + Me * V(2) + Mm * V(3) //Cancels out the movement of the sun due to

vdrift = momentum / (Ms + Me + Mm)  //angular momentum

V = V - vdrift

Xsave = zeros(N, clockmax);  //Array to save the locations

Ysave = zeros(N, clockmax);

Zsave = zeros(N, clockmax);

s = 5 * DES    //s sets what value goes to the axis.

h = zeros(3, 4)    //Creates an array of handles for each subplot

subplot(2,2,1), h(1,1) = plot(X(1), Y(1), 'r*') //Subplot number 1 (Y vs. X)

hold on     //So we don't override the above command with other

     //things

subplot(2,2,1), h(2,1) = plot(X(2), Y(2), 'bo') //Tells what kind of data goes to the circle and stars

subplot(2,2,1), h(3,1) = plot(X(3), Y(3), 'go')

subplot(2,2,1), h_orbits(1,1) = plot(X(1), Y(1), 'r') //Tells the kind of data going into the trails

subplot(2,2,1), h_orbits(2,1) = plot(X(2), Y(2), 'b')

subplot(2,2,1), h_orbits(3,1) = plot(X(3), Y(3), 'g')

hold off     //Tells that the initiating the plot for this graph is over

axis ([-s, s, -s, s])    //Sets the axis range

axis equal    //Sets the axis appearances

axis manual

 

subplot(2,2,2), h(1,2) = plot(Z(1), Y(1), 'r*') //Same as before but for Z vs. Y

hold on

subplot(2,2,2), h(2,2) = plot(Z(2), Y(2), 'bo')

subplot(2,2,2), h(3,2) = plot(Z(3), Y(3), 'go')

subplot(2,2,2), h_orbits(1,2) = plot(Z(1), Y(1), 'r')

subplot(2,2,2), h_orbits(2,2) = plot(Z(2), Y(2), 'b')

subplot(2,2,2), h_orbits(3,2) = plot(Z(3), Y(3), 'g')

hold off

axis ([-s, s, -s, s])

axis equal

axis manual

 

subplot(2,2,3), h(1,3) = plot(X(1), Z(1), 'r*') //Same as above but for Z vs. X

hold on

subplot(2,2,3), h(2,3) = plot(X(2), Z(2), 'bo')

subplot(2,2,3), h(3,3) = plot(X(3), Z(3), 'go')

subplot(2,2,3), h_orbits(1,3) = plot(X(1), Z(1), 'r')

subplot(2,2,3), h_orbits(2,3) = plot(X(2), Z(2), 'b')

subplot(2,2,3), h_orbits(3,3) = plot(X(3), Z(3), 'g')

hold off

axis([-s, s, -s, s])

axis equal

axis manual

 

subplot(2,2,4), h(1,4)=plot3(X(1),Y(1),Z(1),'r*') //Plot for the 3D graph

hold on

subplot(2,2,4), h(2,4)=plot3(X(2),Y(2),Z(2),'bo')

subplot(2,2,4), h(3,4)=plot3(X(3),Y(3),Z(3),'go')

subplot(2,2,4), h_orbits(1,4)=plot3(X(1),Y(1),Z(1),'r')

subplot(2,2,4), h_orbits(2,4)=plot3(X(2),Y(2),Z(2),'b')

subplot(2,2,4), h_orbits(3,4)=plot3(X(3),Y(3),Z(3),'g')

hold off

axis([-s,s,-s,s,-s,s])

axis manual

drawnow    //drawnow to update figure window

figure(1)     //Creates the figure window

for clock = 1 : clockmax   //Loop for each time step

    for i = 1 : N    //Loop for each bodies

       for j = 1 : N    //Loop for each bodies affecting the body set using the

     //above loop

          if (j ~= i)    //To exclude the effect of body influencing its own

     //velocity

              DX = X(j) - X(i);  //Finds the X, Y, Z distance of each bodies

              DY = Y(j) - Y(i);

              DZ = Z(j) - Z(i);

                R = sqrt(DX^2 + DY^2 + DZ^2); //Finds the 3D distance

                U(i) = U(i) + dt * G * M(j) * DX / R^3; //Adds on to the velocity that was there before

                V(i) = V(i) + dt * G * M(j) * DY / R^3; //affected by both bodies

                W(i) = W(i) + dt * G * M(j) * DZ / R^3;

          end    //end of if

       end    //On to the next body affecting

    end     //On to the next body being affected.

    

    for i = 1 : N    //Loop to update the locations using the velocity

        X(i) = X(i) + dt * U(i);

        Y(i) = Y(i) + dt * V(i);

        Z(i) = Z(i) + dt * W(i);

    end     //On to the next body

    Xsave(:, clock) = X;   //Saving the location values

    Ysave(:, clock) = Y;

    Zsave(:, clock) = Z;

    

    for i = 1 : N    //Plotting command for the star and circles.

        set (h(i,1), 'xdata', X(i), 'ydata', Y(i))

        set (h(i,2), 'xdata', Z(i), 'ydata', Y(i))

        set (h(i,3), 'xdata', X(i), 'ydata', Z(i))

        set (h(i,4), 'xdata', X(i), 'ydata', Y(i), 'zdata', Z(i))

    end     //On to the next body

    

    for i = 1 : N    //Plotting command for the trails

        set (h_orbits(i,1), 'xdata', Xsave(i, 1:clock), 'ydata', Ysave(i, 1:clock))

        set (h_orbits(i,2), 'xdata', Zsave(i, 1:clock), 'ydata', Ysave(i, 1:clock))

        set (h_orbits(i,3), 'xdata', Xsave(i, 1:clock), 'ydata', Zsave(i, 1:clock))

        set (h_orbits(i,4), 'xdata', Xsave(i, 1:clock), 'ydata', Ysave(i, 1:clock), 'zdata', Zsave(i, 1:clock))

    end     //On to the next body

    drawnow    //Update the graph for each time step

 
end     //End of one time step, moving on to the next clock



