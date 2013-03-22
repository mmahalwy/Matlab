
function dataMatrix = finalexp12(filename)


%opens window
[window,rect]=Screen('OpenWindow', 0);

%------------------------DEFINING VARIABLES----------------------------

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


%extract data and condition matrix
[ndata, text, alldata] = xlsread('testwords.xls');
%build matrix for BWcondition and Color output

%randomizing SOA
soa=[0.01 0.02 0.03];
soa=Shuffle(soa);

%defining colors
r = [255 0 0];
b = [50 105 255];
g = [0 205 0];
colorSel=[1 2];

%puts in a colour
Screen('FillRect',window, [255 255 255]);
Screen('Flip',window);

%---------------------------INTRUCTIONS---------------------------------
%Waiting to start Instructions
Screen('TextSize', window , 30);
Screen('FillRect', window, [255 255 255]);
Screen('DrawText', window, 'When ready press A',525,300);
Screen('Flip',window);
wait=1;
while wait==1
    [keyIsDown,secs,keyCode]=KbCheck(theKeyboard); 
    if keyCode(tleftKey)==1
        wait=0;
    end
end
%Instructions
Screen('TextSize', window , 30);
Screen('FillRect', window, [255 255 255]);
Screen('DrawText', window, 'Hey there!',575,300);
Screen('Flip',window);
WaitSecs(2); 
Screen('TextSize', window , 30);
Screen('FillRect', window, [255 255 255]);
Screen('DrawText', window, 'Thank you for participating in our experiment',325,300);
Screen('Flip',window);
WaitSecs(2); 
Screen('TextSize', window , 30);
Screen('FillRect', window, [255 255 255]);
Screen('DrawText', window, 'The experiment is really easy,',325,300);
Screen('DrawText', window, 'a word will flash in the center of the screen',325,350);
Screen('DrawText', window, 'Then 4 word choices will appear afterwords',325,400);
Screen('Flip',window);
WaitSecs(4); 
Screen('TextSize', window , 30);
Screen('FillRect', window, [255 255 255]);
Screen('DrawText', window, 'Your task: choose the correct word that you saw',325,300);
Screen('DrawText', window, 'If unsure, select a word that you think you saw',325,350);
Screen('Flip',window);
WaitSecs(4);
Screen('TextSize', window , 30);
Screen('FillRect', window, [255 255 255]);
Screen('DrawText', window, 'The word choices will correspond to the',325,300);
Screen('DrawText', window, 'following keys:',325,350);
Screen('Flip',window);
WaitSecs(3);

%Key instructions
Screen('TextSize', window , 30); 
Screen('FillRect', window, [255 255 255]); 
Screen('DrawText',window, 'Press A' , 375,350, [0 0 0])
Screen('DrawText',window, 'Press Z' , 450,450, [0 0 0])
Screen('DrawText',window, 'Press M', 750,450, [0 0 0])
Screen('DrawText',window, 'Press K', 825,350, [0 0 0])
Screen('Flip',window);
WaitSecs(3);
Screen('TextSize', window , 30); 
Screen('FillRect', window, [255 255 255]); 
Screen('DrawText',window, 'Press A' , 375,350, [0 0 0])
Screen('DrawText',window, 'Press Z' , 450,450, [0 0 0])
Screen('DrawText',window, 'Press M', 750,450, [0 0 0])
Screen('DrawText',window, 'Press K', 825,350, [0 0 0])
Screen('DrawText',window, 'Place your fingers on the keys to get ready!', 375,500, [255 0 0])
Screen('Flip',window);
WaitSecs(3); 


%Waiting to start experiment
Screen('TextSize', window , 30);
Screen('FillRect', window, [255 255 255]);
Screen('DrawText', window, 'When ready press A',525,300);
Screen('Flip',window);
wait=1;
while wait==1
    [keyIsDown,secs,keyCode]=KbCheck(theKeyboard); %looking for key to be pressed
    if keyCode(tleftKey)==1
        wait=0;
    end
end

%--------------------------------Begin Experiment-------------------------
trialCounter=1
for soaVar=1:3
doneExp = 0;
conditionMatrix = [repmat(0,1,24); repmat(1,1,8), repmat(2,1,8),repmat(3,1,8)]';
wordSize = 4;
while doneExp == 0;
    
    doneLooking=0;
    while doneLooking == 0;
        %Random Rows
        theRow= round(1 + (24-1).*rand(1,1)); %outputs a random number;
        if conditionMatrix(theRow,1) <3
            doneLooking = 1;
        end
    end
    
    %Random other words, made sure it is not same as theWord
    wordNumbers=0;
    while wordNumbers==0
        other1= round(1 + (24-1).*rand(1,1));
        other2= round(1 + (24-1).*rand(1,1));
        other3= round(1 + (24-1).*rand(1,1));
        if theRow~=other1 && theRow~=other2 && theRow~=other3
            wordNumbers=1;
        end
    end
    
    %Dynamic variables
    theWord= alldata(theRow,1);
    BWcondition = conditionMatrix(theRow,1);
    theColor = conditionMatrix(theRow,2);
    otherWord1= alldata(other1,1);
    otherWord2= alldata(other2,1);
    otherWord3= alldata(other3,1);
    
    %Cue Screen
    Screen('FillRect',window, [255 255 255]);
    Screen('Flip', window);
   
    
    %Conditions
    if BWcondition == 0
        %present in black
        Screen('TextSize', window , 50);
        Screen('DrawText',window, sprintf('%s', cell2mat(theWord)) , 600,400, [0 0 0])
        Screen('Flip', window);
        %add one to the BWcondition
        conditionMatrix(theRow,1)= conditionMatrix(theRow,1)+1;
        
    elseif BWcondition ==1
        %present in color
        if theColor==1
            %present in red
            Screen('TextSize', window , 50);
            Screen('DrawText',window, sprintf('%s', cell2mat(theWord)), 600,400, r)
            Screen('Flip', window);
        elseif theColor==2
            %present in blue
            Screen('TextSize', window , 50);
            Screen('DrawText',window, sprintf('%s', cell2mat(theWord)), 600,400, b)
            Screen('Flip', window);
        elseif theColor==3
            %present in green
            Screen('TextSize', window , 50);
            Screen('DrawText',window, sprintf('%s', cell2mat(theWord)), 600,400, g)
            Screen('Flip', window);
        end
        %add one to the BWcondition
        conditionMatrix(theRow,1)= conditionMatrix(theRow,1)+1;
    elseif BWcondition ==2
         %present in color
        if theColor==1
            %if color is red, present in blue or green
            colorVar=[b;g];
            colorSel=Shuffle(colorSel);
            theWord
            Screen('TextSize', window , 50);
            Screen('DrawText',window, sprintf('%s', cell2mat(theWord)), 600,400, colorVar(colorSel(1,1),:))
            Screen('Flip', window);
        elseif theColor==2
            %if color is blue, present in green or red
            colorVar=[r;g];
            colorSel=Shuffle(colorSel);
            theWord
            Screen('TextSize', window , 50);
            Screen('DrawText',window, sprintf('%s', cell2mat(theWord)), 600,400, colorVar(colorSel(1,1),:))
            Screen('Flip', window);
        elseif theColor==3
            %if color is green, present in red or blue
            colorVar=[b;r];
            colorSel=Shuffle(colorSel);
            theWord
            Screen('TextSize', window , 50);
            Screen('DrawText',window, sprintf('%s', cell2mat(theWord)), 600,400, colorVar(colorSel(1,1),:))
            Screen('Flip', window);
        end
        %add one to the BWcondition
        conditionMatrix(theRow,1)= conditionMatrix(theRow,1)+1;
    end
    
    
    %Varied SOA by the loop
    if soaVar==1
        soaRand= soa(1,1);
    elseif soaVar==2
        soaRand=soa(1,2);
    else
        soaRand=soa(1,3);
    end
    WaitSecs(soaRand);
    
    %mask
    Screen('PutImage', window, mask);
    Screen('Flip', window);
    WaitSecs(0.5);
    
    
    %Choice of words
    %created a matrix between the words and number 1:4 (choice of spot)
    wordChoice=[theWord otherWord1 otherWord2 otherWord3];
    wordChoice=Shuffle(wordChoice);
    
    %find theWord when shuffled
    [truefalse, index] = ismember(theWord, wordChoice);
    
    %inputting the words within the different spots
    varChoice1= wordChoice(1,1);
    varChoice2= wordChoice(1,2);
    varChoice3= wordChoice(1,3);
    varChoice4= wordChoice(1,4);
    
    %present the word choices
    Screen('TextSize', window , 50);
    Screen('FillRect', window, [255 255 255]);
    Screen('DrawText',window, sprintf('%s', cell2mat(varChoice1)), 375,350, [0 0 0])
    Screen('DrawText',window, sprintf('%s', cell2mat(varChoice2)), 450,450, [0 0 0])
    Screen('DrawText',window, sprintf('%s', cell2mat(varChoice3)), 750,450, [0 0 0])
    Screen('DrawText',window, sprintf('%s', cell2mat(varChoice4)), 825,350, [0 0 0])
    Screen('Flip',window);
    
    
    %timer for RT, start
    startTime=GetSecs;
    
    %wait key press
    waiting=1;
    while waiting==1
        [keyIsDown,secs,keyCode]=KbCheck(theKeyboard); %looking for key to be pressed
        if keyCode(tleftKey)==1
            theResponse=1;
            waiting=0;
        elseif keyCode(bleftKey)==1
            theResponse=2;
            waiting=0;
        elseif keyCode(brightKey)==1
            theResponse=3;
            waiting=0;
        elseif keyCode(trightKey)==1
            theResponse=4;
            waiting=0;
        end
        %end RT timer
        endTime=GetSecs;
    end
    
    %Determine RT
    RT=(endTime - startTime);
    
    %Recording accuracy
    if theResponse==index %index is location of theWord, finding if pressed correctly
        accuracy=1; %if accurate
    else
        accuracy=0; %if incorrect
    end
    
    %recording data
dataMatrix(trialCounter,:)=[trialCounter, wordSize, soaRand, theRow, BWcondition, theColor, theResponse, accuracy, RT];    
dlmwrite(filename, dataMatrix);

    %trial counter
    trialCounter = trialCounter+1;
    
    
    %word will not be used if BWcondition=2, end while loop when BWcondition addition is 72
    sumWords = sum(conditionMatrix(:,1)); %to add all the data
    if sumWords ==72
        doneExp = 1;
    end
    
    
end
end
Screen('PutImage', window, mask);
Screen('Flip', window);
WaitSecs(0.5);

%--------------------END OF 4 LETTER WORDS, BEGIN 5 LETTER------------------
%Break and instructions
[ndata, text, alldata] = xlsread('testwords2.xls');
Screen('TextSize', window , 30); 
Screen('FillRect', window, [255 255 255]); 
Screen('DrawText', window, 'Take 15 seconds break',550,300);
Screen('DrawText', window, 'You are doing awesome',550,350);
Screen('Flip',window);
WaitSecs(15); 
Screen('TextSize', window , 30);
Screen('FillRect', window, [255 255 255]);
Screen('DrawText', window, 'Ready?',575,300);
Screen('Flip',window);
WaitSecs(2);

%Waiting to start experiment
Screen('TextSize', window , 30);
Screen('FillRect', window, [255 255 255]);
Screen('DrawText', window, 'When ready press A',525,300);
Screen('Flip',window);
wait=1;
while wait==1
    [keyIsDown,secs,keyCode]=KbCheck(theKeyboard); %looking for key to be pressed
    if keyCode(tleftKey)==1
        wait=0;
    end
end
%--------------------------------Begin Experiment-------------------------
for soaVar=1:3
doneExp = 0;
conditionMatrix = [repmat(0,1,39); repmat(1,1,13), repmat(2,1,13),repmat(3,1,13)]';
wordSize = 5;
while doneExp == 0;
    
    doneLooking=0;
    while doneLooking == 0;
        %Random Rows
        theRow= round(1 + (39-1).*rand(1,1)); %outputs a random number;
        if conditionMatrix(theRow,1) <3
            doneLooking = 1;
        end
    end
    
    %Random other words, made sure it is not same as theWord
    wordNumbers=0;
    while wordNumbers==0
        other1= round(1 + (39-1).*rand(1,1));
        other2= round(1 + (39-1).*rand(1,1));
        other3= round(1 + (39-1).*rand(1,1));
        if theRow~=other1 && theRow~=other2 && theRow~=other3
            wordNumbers=1;
        end
    end
    
    %Dynamic variables
    theWord= alldata(theRow,1);
    BWcondition = conditionMatrix(theRow,1);
    theColor = conditionMatrix(theRow,2);
    otherWord1= alldata(other1,1);
    otherWord2= alldata(other2,1);
    otherWord3= alldata(other3,1);
    
    %Cue Screen
    Screen('FillRect',window, [255 255 255]);
    Screen('Flip', window);
    
   %Conditions
    if BWcondition == 0
        %present in black
        Screen('TextSize', window , 50);
        Screen('DrawText',window, sprintf('%s', cell2mat(theWord)) , 600,400, [0 0 0])
        Screen('Flip', window);
        %add one to the BWcondition
        conditionMatrix(theRow,1)= conditionMatrix(theRow,1)+1;
        
    elseif BWcondition ==1
        %present in color
        if theColor==1
            %present in red
            Screen('TextSize', window , 50);
            Screen('DrawText',window, sprintf('%s', cell2mat(theWord)), 600,400, r)
            Screen('Flip', window);
        elseif theColor==2
            %present in blue
            Screen('TextSize', window , 50);
            Screen('DrawText',window, sprintf('%s', cell2mat(theWord)), 600,400, b)
            Screen('Flip', window);
        elseif theColor==3
            %present in green
            Screen('TextSize', window , 50);
            Screen('DrawText',window, sprintf('%s', cell2mat(theWord)), 600,400, g)
            Screen('Flip', window);
        end
        %add one to the BWcondition
        conditionMatrix(theRow,1)= conditionMatrix(theRow,1)+1;
    elseif BWcondition ==2
         %present in color
        if theColor==1
            %if color is red, present in blue or green
            colorVar=[b;g];
            colorSel=Shuffle(colorSel);
            theWord
            Screen('TextSize', window , 50);
            Screen('DrawText',window, sprintf('%s', cell2mat(theWord)), 600,400, colorVar(colorSel(1,1),:))
            Screen('Flip', window);
        elseif theColor==2
            %if color is blue, present in green or red
            colorVar=[r;g];
            colorSel=Shuffle(colorSel);
            theWord
            Screen('TextSize', window , 50);
            Screen('DrawText',window, sprintf('%s', cell2mat(theWord)), 600,400, colorVar(colorSel(1,1),:))
            Screen('Flip', window);
        elseif theColor==3
            %if color is green, present in red or blue
            colorVar=[b;r];
            colorSel=Shuffle(colorSel);
            theWord
            Screen('TextSize', window , 50);
            Screen('DrawText',window, sprintf('%s', cell2mat(theWord)), 600,400, colorVar(colorSel(1,1),:))
            Screen('Flip', window);
        end
        %add one to the BWcondition
        conditionMatrix(theRow,1)= conditionMatrix(theRow,1)+1;
    end
    
    
    %Varied SOA by the loop
    if soaVar==1
        soaRand= soa(1,1);
    elseif soaVar==2
        soaRand=soa(1,2);
    else
        soaRand=soa(1,3);
    end
    WaitSecs(soaRand);
    
    %mask
    Screen('PutImage', window, mask);
    Screen('Flip', window);
    WaitSecs(0.5);
    
    
    %Choice of words
    %created a matrix between the words and number 1:4 (choice of spot)
    wordChoice=[theWord otherWord1 otherWord2 otherWord3];
    wordChoice=Shuffle(wordChoice);
    
    %find theWord when shuffled
    [truefalse, index] = ismember(theWord, wordChoice);
    
    %inputting the words within the different spots
    varChoice1= wordChoice(1,1);
    varChoice2= wordChoice(1,2);
    varChoice3= wordChoice(1,3);
    varChoice4= wordChoice(1,4);
    
    %present the word choices
    Screen('TextSize', window , 50);
    Screen('FillRect', window, [255 255 255]);
    Screen('DrawText',window, sprintf('%s', cell2mat(varChoice1)), 375,350, [0 0 0])
    Screen('DrawText',window, sprintf('%s', cell2mat(varChoice2)), 450,450, [0 0 0])
    Screen('DrawText',window, sprintf('%s', cell2mat(varChoice3)), 750,450, [0 0 0])
    Screen('DrawText',window, sprintf('%s', cell2mat(varChoice4)), 825,350, [0 0 0])
    Screen('Flip',window);
    
    
    %timer for RT, start
    startTime=GetSecs;
    
    %wait key press
    waiting=1;
    while waiting==1
        [keyIsDown,secs,keyCode]=KbCheck(theKeyboard); %looking for key to be pressed
        if keyCode(tleftKey)==1
            theResponse=1;
            waiting=0;
        elseif keyCode(bleftKey)==1
            theResponse=2;
            waiting=0;
        elseif keyCode(brightKey)==1
            theResponse=3;
            waiting=0;
        elseif keyCode(trightKey)==1
            theResponse=4;
            waiting=0;
        end
        %end RT timer
        endTime=GetSecs;
    end
    
    %Determine RT
    RT=(endTime - startTime);
    
    %Recording accuracy
    if theResponse==index %index is location of theWord, finding if pressed correctly
        accuracy=1; %if accurate
    else
        accuracy=0; %if incorrect
    end
    
    %recording data
dataMatrix(trialCounter,:)=[trialCounter, wordSize, soaRand, theRow, BWcondition, theColor, theResponse, accuracy, RT];        dlmwrite(filename, dataMatrix);
    
    trialCounter = trialCounter+1;
    
    
    %word will not be used if BWcondition=2, end while loop when BWcondition addition is 72
    sumWords = sum(conditionMatrix(:,1)); %to add all the data
    if sumWords ==117
        doneExp = 1;
    end
    
    
end
end

%-----------------------------THANK NOTES----------------------------------
Screen('TextSize', window , 30);
Screen('FillRect', window, [255 255 255]); 
Screen('DrawText', window, 'Thank you for doing the experiment!',500,300);
Screen('Flip',window);
WaitSecs(1); 
Screen('TextSize', window , 30); 
Screen('FillRect', window, [255 255 255]); 
Screen('DrawText', window, 'Be sure to tell a supervisor you are done',450,300);
Screen('Flip',window);
WaitSecs(1);

%close window
Screen('CloseAll') 

end


