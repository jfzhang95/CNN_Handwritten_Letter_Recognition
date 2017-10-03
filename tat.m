%9%�Ĵ�����
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
  
% �����cnn�����ø�cnnsetup������ݴ˹���һ��������CNN���磬������  
cnn = cnnsetup(cnn, train_x, train_y);  
  
% ѧϰ��  
opts.alpha = 1;  
% ÿ������һ��batchsize��batch��ѵ����Ҳ����ÿ��batchsize�������͵���һ��Ȩֵ��������  
% �����������������ˣ�������������������˲ŵ���һ��Ȩֵ  
opts.batchsize = 100;   
% ѵ����������ͬ��������������ѵ����ʱ��  
% 1��ʱ�� 11.41% error  
% 5��ʱ�� 4.2% error  
% 10��ʱ�� 2.73% error  
opts.numepochs = 40;  

% Ȼ��ʼ��ѵ��������������ʼѵ�����CNN����  
cnn= cnntrain(cnn, train_x, train_y, opts);  
% Ȼ����ò�������������  
[er, bad] = cnntest(cnn, test_x, test_y);  
  
%plot mean squared error  
plot(cnn.rL);  
%show test error  
disp([num2str(er*100) '% error']);  