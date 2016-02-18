resultsMatrix = zeros(length(classVector),length(classVector));
resultsPercentMatrix = zeros(rows(resultsMatrix),rows(resultsMatrix));


for i = 1:length(testLabels)
	resultsMatrix(testLabels(i),testPredictions(i))++;
endfor

for i = 1:rows(resultsMatrix)
	for j = 1:columns(resultsMatrix)
		resultsPercentMatrix(i,j) = 100*(resultsMatrix(i,j)/sum(resultsMatrix(i,:)));
	endfor
endfor

fprintf(' \n****************************************************************************************** \n\n');
fprintf(' TOTAL CLASSIFIED CORRECT: %.2f%% \n', percentCorrect);


for i = 1:length(classVector)
	fprintf(' \n****************************************************************************************** \n\n');
	fprintf(' CLASS %.0f: \t\t\t %s \n', i, classVector{i});
	fprintf(' CORRECT CLASSIFICATIONS:\t %.2f%% \n\n', 100*(resultsMatrix(i,i)/sum(resultsMatrix(i,:))));
	fprintf(' MISCLASSIFICATIONS: \t\t %.2f%%\n', 100-(100*(resultsMatrix(i,i)/sum(resultsMatrix(i,:)))));


	for j = 1:length(classVector)


		if(resultsMatrix(i,j)>0 && resultsMatrix(i,j) != resultsMatrix(i,i))
			fprintf(' -Misclassifed to class %.0f: \t %.2f%% \n',j, 100*((resultsMatrix(i,j)/sum(resultsMatrix(i,:)))));
		endif


	endfor

endfor

