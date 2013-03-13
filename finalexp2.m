
%opens window
[window,rect]=Screen('OpenWindow', 0); %I defined 0 as the master screen, to output on secondary, window set to '1'
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
[ndata, text, alldata] = xlsread('testmatlab.xls');



%begin experiment
doneLooking=0;
while doneLooking == 0
    theRow= round(1 + (36-1).*rand(1,1)) %outputs a random number;
    theWord= alldata(theRow,1);
    BWcondition = alldata(theRow,2);
    theColor = alldata(theRow,3);
    if BWcondition == 0
        %present in black
        doneLooking==1;
    elseif BWcondition ==1
        %present in color
    else
        %find new word
        doneLooking = 0;
    end
    alldata(theRow,2)= alldata(theRow,2)+1;
    sumAll = sum(cell2mat(alldata(:,2))) %to add all the data 
    if sumAll ==72 
        break
    end
end




[ndata, text, alldata] = xlsread('testmatlab.xls')