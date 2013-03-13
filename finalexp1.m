doneLooking=0;
while doneLooking == 0
    theRow= pickrandomrow;
    theWord= experimentMatrix(theRow,1);
    BWcondition = experimentMatrix(theRow,2);
    theColor = experimentMatrix(theRow,3);
    if BWcondition == 0
        %present in black
        doneLooking==1;
    elseif BWcondition ==1
        %present in color
    else
        %find new word
        doneLooking = 0;
    end
end

experimentMatrix(theRow,2)= experimentMatrix(theRow,2)+1;