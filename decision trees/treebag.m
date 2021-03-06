%%------------RAndom forests--------------------------%%
clear all, close all; 
rng default;   %controlling the random number generator 

%% loading the training and test data
Data = csvread('contest_train.csv');
N = size(Data,2);
M = size(Data,1);
trainData = Data(1:M,:);

features = trainData(:,1:N-1);
classLabels = trainData(:,N);

Data2= trainData(randperm(M),:);
testData = Data2(M/2+1:M,:);

X = testData(:,1:N-1);
Y = testData(:,N);

%% visualise the data
%plotData(features,classLabels);
%legend('class 1','class 0')
%hold on;

% number of trees desired in the forest
nTrees = 20;

%% training the treebagger(decision forest)
B = TreeBagger(nTrees, features, classLabels,'Method', 'classification');


%% predicting the class label for the crossvalidation set
%predictClass = zeros(size(testData,1),1);
%for i = 1:size(testData,1)
    predChar1 = predict(B,testData(:,1:N-1));
    predictClass = str2double(predChar1); %converting from string to number
%end
%% ------------------confusion matrix------------------------------%%
[Y predictClass]


%hold on;
C  = confusionmat(Y,predictClass)
%per class precision
%precisionA =  C(1,1)./(C(1,1)+C(2,1));
%precisionB =  C(2,2)./(C(1,2)+C(2,2));



%recall
%recallA =  C(1,1)./(C(1,1)+C(1,2));
%recallB =  C(2,2)./(C(2,1)+C(2,2));

%f-measure
%F1 = 2*precisionA*recallA./(precisionA+recallA)
%F2 = 2*precisionB*recallB./(precisionB+recallB)

accuracy = (C(1,1)+C(2,2))./(C(1,1)+C(1,2)+C(2,1)+C(2,2))*100