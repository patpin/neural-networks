%% Network configuration

imgW = 400; % image width, ( width >= height )
imgH = 200; % image height

cnn = cell(1, 1); % for convolution layers L2

% L2
cnn{1}.inputWidth = imgW;
cnn{1}.inputHeight = imgH;
cnn{1}.inputChannels = 1;
cnn{1}.features = 100;
cnn{1}.patchSize = 6;
cnn{1}.poolSize = 10;
cnn{1}.numPatches = 100000;
cnn{1}.inputVisibleSize = cnn{1}.patchSize * cnn{1}.patchSize * cnn{1}.inputChannels;

cnn{1}.outputWidth = floor((cnn{1}.inputWidth - cnn{1}.patchSize + 1) / cnn{1}.poolSize);
cnn{1}.outputHeight = floor((cnn{1}.inputHeight - cnn{1}.patchSize + 1) / cnn{1}.poolSize);
cnn{1}.outputChannels = cnn{1}.features;
cnn{1}.outputSize = cnn{1}.outputWidth * cnn{1}.outputHeight * cnn{1}.outputChannels;

saeSparsityParam = 0.01;   % desired average activation of the hidden units.
saeLambda = 0.003;     % weight decay for SAE (sparse auto-encoders)       
saeBeta = 3;            % weight of sparsity penalty term       

convolutionsStepSize = 50;

% L3
inputSizeL3 = cnn{1}.outputSize; 

% L4
inputSizeL4 = 1000;

mlpLambda = 1e-4; % weight decay for L4-L5

% !! WHEN CHANGE batchSize - CLEAN UP / DELETE TEMP DIRECTORY (tempDir)
batchSize = 210; % batch size for mini-batch algorithm
numTrainIterL3L4 = 1000; % L4L5 amount of iterations over whole training set
numOutputClasses = 30; % amount of output lables, classes (e.g. coins)

addpath ../libs/         % load libs
addpath ../libs/minFunc/

%  Use minFunc to minimize cost functions
saeOptions.Method = 'lbfgs'; % Use L-BFGS to optimize our cost function.
saeOptions.maxIter = 800;	  % Maximum number of iterations of L-BFGS to run 
saeOptions.display = 'on';

mlpOptions.Method = 'lbfgs'; % Use L-BFGS to optimize our cost function.
mlpOptions.maxIter = 1; % update minFunc confugs for mini batch 
mlpOptions.display = 'on';