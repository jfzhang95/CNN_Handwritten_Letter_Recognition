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
sumx=0;sumy=0;
for i=1:124800
    max=[0,0];min=[28,28];
    for j=1:28
        for k=1:28
            if train_x(j,k,i)>0.5
                if j>max(1)
                    max(1)=j;
                else if j<=min(1)
                        min(1)=j;
                    end
                end
                if k>max(2)
                    max(2)=k;
                else if k<=min(2)
                        min(2)=k;
                    end
                end
            end
        end
    end
    sumx=sumx+max(1)-min(1);
    sumy=sumy+max(2)-min(2);
end
avx=sumx/124800;
avy=sumy/124800;
%avx=19.2936平均行数
%avy=17,2399平均列数