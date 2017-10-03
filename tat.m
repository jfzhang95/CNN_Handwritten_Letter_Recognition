%9%的错误率
clear all; close all; clc;  
addpath('D:MATLAB/toolbox/DeepLearnToolbox-master/data');  
addpath('D:MATLAB/toolbox/DeepLearnToolbox-master/util');  
load('E:\character\matlab\emnist-letters.mat')
train_x=dataset.train.images;
train_yt=dataset.train.labels;
test_x=dataset.test.images;
test_yt=dataset.test.labels;
train_y=zeros(26,124800);
test_y=zeros(26,20800);
for i=1:124800
    j=train_yt(i);
    train_y(j,i)=1;
end
for i=1:20800
    j=test_yt(i);
    test_y(j,i)=1;
end
train_x = double(reshape(train_x',28,28,124800))/255;  
test_x = double(reshape(test_x',28,28,20800))/255;  
train_y = double(train_y);  
test_y = double(test_y);  
  
%% ex1   
%will run 1 epoch in about 200 second and get around 11% error.   
%With 100 epochs you'll get around 1.2% error  
  
cnn.layers = {  
    struct('type', 'i') %input layer  
    struct('type', 'c', 'outputmaps', 12, 'kernelsize', 5) %convolution layer  
    struct('type', 's', 'scale', 2) %sub sampling layer  
    struct('type', 'c', 'outputmaps', 24, 'kernelsize', 5) %convolution layer  
    struct('type', 's', 'scale', 2) %subsampling layer  
};  
  
% 这里把cnn的设置给cnnsetup，它会据此构建一个完整的CNN网络，并返回  
cnn = cnnsetup(cnn, train_x, train_y);  
  
% 学习率  
opts.alpha = 1;  
% 每次挑出一个batchsize的batch来训练，也就是每用batchsize个样本就调整一次权值，而不是  
% 把所有样本都输入了，计算所有样本的误差了才调整一次权值  
opts.batchsize = 100;   
% 训练次数，用同样的样本集。我训练的时候：  
% 1的时候 11.41% error  
% 5的时候 4.2% error  
% 10的时候 2.73% error  
opts.numepochs = 40;  

% 然后开始把训练样本给它，开始训练这个CNN网络  
cnn= cnntrain(cnn, train_x, train_y, opts);  
% 然后就用测试样本来测试  
[er, bad] = cnntest(cnn, test_x, test_y);  
  
%plot mean squared error  
plot(cnn.rL);  
%show test error  
disp([num2str(er*100) '% error']);  