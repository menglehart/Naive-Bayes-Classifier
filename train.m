filename = "data/stemmedtraining.txt"; %Save training data a variable. 
text = {}; % Declare cell array to store concatenated document text by class.
fid = fopen (filename); 	%Create a pointer to the training data document. 
newline = fgetl(fid); 	%Get a reference to the first line of the document. 
classVector = {}; 	%Unique classes found in training data labels.
vocab = {}; 	%Unique, tokenized list of all words found in all documents.
classDocCount = []; 	%Vector of doc counts for each class. Index correpsonds with class at same index in classVector.
classProbabilityVector = []; 	%Vector of class prior probabilities. 
classWordCount = {};
wordProbVector = {};


tic %Start clock to time loops.


		%Read in each line from the training data file...
		while (!isnumeric(newline))	 

    		wordVector = strsplit(newline);	%...tokenize words in document...


    		if(!any(strcmp(wordVector(1), classVector))) %...add lable to class vector if it hasnt already been added...
    			classVector(end + 1) = wordVector(1);
    			wordVector(1) = []; %...delete label...
				text{end + 1} = wordVector;	%...add tokenized training example text to concatenated text for class...
				classDocCount(1,end + 1) = 1; %...start a counter for the new class...


			else
				classIndex = strcmp(wordVector(1),classVector); %...if class has already been added to the classVector, get the index of the class...
    			wordVector(1) = []; %...delete the label...
				text{1, classIndex} = [text{1,classIndex} wordVector]; %...add tokenized training example text to concatenated text for appropriate class...                                                                                                                           
				classDocCount(1, classIndex) = classDocCount(1, classIndex) + 1; %...increment document counter for the appropriate class...					
			endif


    		newline = fgetl(fid); % Read a new line in from the file...

		endwhile
		
fclose (fid); %Close the pointer to the document.


toc % Print the elapsed time since the tic to the screen. 


% Add all text for all classes to the vocabulary variable and calulate the prior proability for each class.
for i = 1:length(classVector)
	vocab = [vocab text{i}];
    classProbabilityVector(1,end +1) = classDocCount(i) / sum(classDocCount);
endfor


vocab = unique(vocab); % Remove duplicate occurences of words in vocab.


% Iterate through every class in text and sum the number of word occurences for each word in vocab.
for i = 1:length(text) 
	count = [];
	for j = 1:length(vocab)
		count(1, end + 1) = sum(strcmp(vocab{1,j},text{i}));
	endfor
	classWordCount{end + 1} = count;
	toc
endfor


% Calculate the proability of each word in vocab occuring in each class.
for i = 1:length(text)
	wordProb = [];
	for j = 1:length(vocab)
		wordProb(j) = (classWordCount{1,i}(j) + 1) / (length(text{1,i}) + length(vocab));
	endfor
	wordProbVector{end + 1} = wordProb;
	toc
endfor

toc