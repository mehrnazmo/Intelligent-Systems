close all;
clear all;
clc;
[trainData,trainLabels,valData,valLabels,testData,testLabels] = extractCifar10('/Users/mehrnazmotamed/Documents/MATLAB/Intelligent Systems/HW4/data/Problem_3/cifar-10-batches-mat');

%% Defining the ConvNet
layers = [
    imageInputLayer([32,32,3]);
    
    convolution2dLayer(3,16);
    batchNormalizationLayer();
    reluLayer();
    
    maxPooling2dLayer(2);
    
    convolution2dLayer(3,32);
    batchNormalizationLayer();
    reluLayer();   
    
    maxPooling2dLayer(2);
    
    convolution2dLayer(3,16);
    batchNormalizationLayer();
    reluLayer();    
    
    fullyConnectedLayer(10);
    softmaxLayer();
    classificationLayer()];

%% Defining SGD Parameters
options = trainingOptions('sgdm',...
    'InitialLearnRate',0.001,... 
    'MaxEpochs',20,...
    'MiniBatchSize',128,...
    'ValidationData',{valData,valLabels},... 
    'ValidationFrequency',round(size(trainLabels,1)/128),...
    'Plots','training-progress');


%% Training the Network
net = trainNetwork(trainData,trainLabels,layers,options);


%% Test Data
class_names = categorical({'airplane','automobile','bird','cat','deer','dog','frog','horse','ship','truck'}); % Class Names
YTest = classify(net,testData);
TTest = testLabels;
accuracy = sum(YTest == TTest)/numel(TTest);
test_true_labels = class_names(double(testLabels)); % Test Label names


%% Probability outputs
testFeatures = activations(net,testData,14);


%% Finding True/False Predictions
false_predicts = find(YTest~=TTest);
true_predicts = find(YTest==TTest);



%% Checking different images (False Predictions)
for item = 1:3
    num = false_predicts(item+100);
    figure();
    imagesc(testData(:,:,:,num))
    figure();
    bar(class_names,squeeze(testFeatures(:,:,:,num)))
    test_true_labels(num)
end



%% Checking same images (True Predictions)
for item = 1:3
    num = true_predicts(item+200);
    figure();
    imagesc(testData(:,:,:,num))
    figure();
    bar(class_names,squeeze(testFeatures(:,:,:,num)))
    test_true_labels(num)
end



%% Confusion Plot
c = {'airplane','automobile','bird', 'cat', 'deer', 'dog', 'frog', 'horse', 'ship','truck'};
figure();
plotconfusion(TTest,YTest); 
xticklabels(c); 
yticklabels(c);



%% Bird2 image classification
birds2 = imread('birds2.jpeg');
win_size = 150;
r = floor(win_size/2);
padded = padarray(birds2,[r,r],'symmetric','both'); 
probability_bird = zeros(size(birds2,1),size(birds2,2));

for x = 1+r : size(padded,1)-r
    for y = 1+r : size(padded,2)-r
            contextual_region = padded(x-r:x+r,y-r:y+r,:);
            frame = imresize(contextual_region,[32,32]); 
            testFeatures = activations(net,frame,14);
            probability_bird(x-r,y-r) = squeeze(testFeatures(:,:,3));
    end
end



imagesc(probability_bird);      % Showing the Heatmap
colorbar;

