filename = "data/stemmedtest.txt";
fid = fopen (filename);
newline = fgetl(fid);
testInput = {};
testLabels = [];
testPredictions = [];


tic

% Iterate through each line in the test input...
while (!isnumeric(newline))
    attributeProbVectors = {};
    tempProbs = [];

    wordVector = strsplit(newline); % Tokenize the text in the input line.

    if(columns(wordVector)>1)
        testLabels(end + 1) = find(strcmp(wordVector{1},classVector),1); %Store class index of input in testLabels vector. 
        wordVector(1) = []; % Delete label from input vector.
        testInput{1,end+1} = wordVector; % Add tokenized input to a cell array of vectors.


        % Iterate through each word in the input vector and add the probability of it occuring for each class to the attributeProbVectors.
        for j = 1:length(wordVector)


            if(any(strcmp(wordVector(j),vocab)))
                indexOfWord = find(strcmp(wordVector(j),vocab),1);


                for i = 1:length(classVector)
                    attributeProbVectors{1,i}(end + 1) = wordProbVector{1,i}(indexOfWord);
                endfor

            endif

        endfor


        %Calculate the probability of the document beloning to each class.
        for k = 1:length(classVector)
            tempProbs(k) = sum(log(attributeProbVectors{1,k})) + log(classProbabilityVector(k));
        endfor

        testPredictions(end + 1) = find(tempProbs == max(tempProbs)); % Add class with max probability to testPredictions vector. 

    endif

    newline = fgetl(fid); % Get a new line from the file...

endwhile
        
fclose (fid); 

numInputs = length(testLabels);
numCorrectPredictions = sum(testPredictions == testLabels);
percentCorrect = (numCorrectPredictions/numInputs)*100;

fprintf('--------------------------------------------------------------------------\n');
fprintf('%.2f%% of %.0f input documents classified correctly. \n', percentCorrect, numInputs);
fprintf('--------------------------------------------------------------------------\n');



   









