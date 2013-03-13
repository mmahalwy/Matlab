



function dataMatrix = finalexp4(filename) %to run this all you need to do is type demoExperiment('filename')

%opens window
[window,rect]=Screen('OpenWindow', 1); %I defined 0 as the master screen, to output on secondary, window set to '1'
%puts in a colour
Screen('FillRect',window, [255 255 255]);%fills the window with a colour, RGB
Screen('Flip',window); %flips the newest colour of the window 

%Instructions
Screen('TextSize', window , 30); %define text size
Screen('FillRect', window, [255 255 255]); %fill in color
Screen('DrawText', window, 'Instructions: Press Z if you see a cat and M if you see a Dog',185,300);%instructions
Screen('Flip',window); %flip to front
WaitSecs(0.5); %present instructions for 1s


%------DEFINING VARIABLES-------

%opens file
fopen(filename); 

%Define keyboard and buttons
theKeyboard=GetKeyboardIndices; %names your keyboard
bleftKey=KbName('z'); %left buttom button is z
tleftKey=KbName('a'); %left top button is a
brightKey=KbName('m'); %right button is m
trightKey=KbName('k'); %right button is m

%Defining pictures and reading them
mask=imread('mask.png');


%extract data
[ndata, text, alldata] = xlsread('testmatlab.xls');



%begin experiment
doneLooking=0;

while doneLooking == 0;
    theRow= round(1 + (36-1).*rand(1,1)) %outputs a random number;
    theWord= alldata(theRow,1)
    BWcondition = cell2mat(alldata(theRow,2))
    theColor = cell2mat(alldata(theRow,3))
    Screen('FillRect',window, [255 255 255]);
    Screen('Flip', window);
    if BWcondition == 0
        %present in black
        Screen('TextSize', window , 50);
        Screen('DrawText',window, 'theWord', 600,300)
        WaitSecs(0.5);
        %add one to the BWcondition
        alldata(theRow,2)= cell2mat(alldata(theRow,2))+1;
    
    elseif BWcondition ==1
        %present in color
        if theColor==1
            %present in red
            Screen('TextSize', window , 50);
            Screen('DrawText',window, theWord, 600,300, [150 20 20])
            WaitSecs(0.5);
        elseif theColor==2
            %present in blue
            Screen('TextSize', window , 50);
            Screen('DrawText',window, theWord, 600,300, [20 20 150])
            WaitSecs(0.5);
        elseif theColor==3
            %present in green
            Screen('TextSize', window , 50);
            Screen('DrawText',window, theWord, 600,300, [20 150 20])
            WaitSecs(0.5);
        end
        
        %add one to the BWcondition
        alldata(theRow,2)= cell2mat(alldata(theRow,2))+1;
    
    else %if BWcondition ==2
        %find new word
        doneLooking = 0;
    end
    
    
    %check to see if addition is all equal to 3
    sumAll = sum(cell2mat(alldata(:,2))) %to add all the data 
    if sumAll ==72 
        doneLooking = 1;
    end
end


end


