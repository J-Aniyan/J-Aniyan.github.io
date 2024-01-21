clear all;
close all;
clc;
%% Intro
fprintf('Welcome to Conway''s Game of Life! \n\n');   %gives brief description of game and rules.
fprintf('The game of life is a cellular automaton made by John Horton Conway. Simple rules applied to a grid of squares \n(black is alive, white is dead) give rise to complex formations. \n');
fprintf('The rules are: \n1. Any cell with less than 2 neighbours dies (isolation). \n');
fprintf('2. Any cell with 2 or 3 neighbours lives on to the next generation. \n');         
fprintf('3. Any live cell with more than 3 neighbours dies (overpopulation). \n');
fprintf('4. Any dead cell with exactly 3 live neighbours becomes alive (reproduction). \n\n');
fprintf('Many configurations have been found to give interesting results. You can explore some of these in this program. \n');
fprintf('Oscillators are patterns that repeat and have a period. \nMethuselahs have a small initial pattern which expands for many generations before stabalizing. \n\n');

%% Menu
response = input('Do you wish to proceed?  (Y/N)\n','s');   %asks user to proceed or exit game, to confirm they have read intro + rules.
if response == 'Y' | response == 'y'
    method = menu('How would you like to play?','random','glider','oscillator 1','methuselah 1','oscillator 2','methuselah 2','methuselah 3');
elseif response == 'N' | response == 'n'
    fprintf('You have exited the program. Click ''run'' to start again. \n');
    return
else 
  fprintf('You must enter either choose Y or N, please click ''run'' again. \n');
  return
end

A = sparse(51,51);          %51 by 51 2d array will be used to base calculations

%configurations
glider = [0,1,0;0,0,1;1,1,1];
osclliator1  = [0,1,0;1,1,1];
methuselah1  = [0,1,1;1,1,0;0,1,0];
oscillator2  = [1,1,1,0,0,0;1,1,1,0,0,0;1,1,1,0,0,0;0,0,0,1,1,1;0,0,0,1,1,1;0,0,0,1,1,1];
methuselha2  = [1,1,1,;1,0,1;1,0,1];
methuselha3  = [1,0,1,1;1,1,1,0;0,1,0,0];

%case structure for each config
switch method
    case 1
        A(2:50,2:50) = rand(49,49);      %edges have fixed value = 0
        prompt1 = 'Please enter probability of live cells (as X% where you input X) \n';
        prompt2 = 'Please enter number of generations \n';
        p = input(prompt1);         %probability of initial live cells.
        gen = input(prompt2);       %no. of generations the simulation will play out
        B = (A > ((100-p)/100));    %second array to perform calculations
    case 2
        A(6:8,6:8) = glider;                                   %appears to move through the grid.
        B = A;      
        prompt2 = 'Please enter number of generations \n';
        gen = input(prompt2);
    case 3
        A(24:25,24:26) = osclliator1;                          %repeats pattern with a period.
        B = A;
        prompt2 = 'Please enter number of generations \n';
        gen = input(prompt2);
    case 4
        A(24:26,24:26) = methuselah1;                          %starts small, then expands over many generations.
        B = A;
        prompt2 = 'Please enter number of generations \n';
        gen = input(prompt2);
    case 5
        A(22:27,22:27) = oscillator2;
        B = A;
        prompt2 = 'Please enter number of generations \n';
        gen = input(prompt2);
    case 6
        A(24:26,24:26) = methuselha2;
        B = A;
        prompt2 = 'Please enter number of generations \n';
        gen = input(prompt2);
    case 7
        A(12:14,24:27) = methuselha3;
        B = A;
        prompt2 = 'Please enter number of generations \n';
        gen = input(prompt2);
end
  
 %% Calculation
for t = 1:gen
 
    A = sparse(51,51);
    %nested for loop to go through each row (i) and column (j)
      for i = 2:50
        for j = 2:50
            alive = countCells(B,i,j);                              
             if B(i,j) == 1 && alive < 2                            %Death by isolation
                A(i,j) = 0; 
            elseif B(i,j) == 1 && alive > 3                         %Death by overpopulation
                A(i,j) = 0;
            elseif B(i,j) == 1 && ((alive == 2) || (alive == 3))    %Stays alive if cell has 2 or 3 live neighbours
                A(i,j) = 1;
            elseif B(i,j) == 0 && alive == 3                        %Birth
                A(i,j) = 1;
            end
        end
      end
    B = A;                  %new calculated values (A) assigned back to G 
    spy(B,'sk');
    title('Game Of Life');
    subtitle(num2str(t));   %live display of generation number
    drawnow
end
fprintf('The program has ended, click run to start again and try another option. \n');
%% FUNCTION 
function neighbours = countCells(X,i,j)
%Counts neighbours around each cell
%each cell has 8 neighbours, this function counts each around a given cell.

neighbours = X(i+1,j) + X(i,j+1) + X(i-1,j) + X(i,j-1) + X(i+1,j+1) + X(i-1,j-1) + X(i-1,j+1) + X(i+1,j-1);

end


