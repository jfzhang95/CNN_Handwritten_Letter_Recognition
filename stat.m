clear all; close all; clc;   
load('emnist-letters.mat');
test_x=dataset.test.images;
test_yt=dataset.test.labels;
test_y=zeros(26,20800);
for i=1:20800
    j=test_yt(i);
    test_y(j,i)=1;
end
test_x = double(reshape(test_x',28,28,20800))/255;  
test_y = double(test_y);
load('cnnright2.mat');
net = cnnff(cnn, test_x);
[~, h] = max(net.o);
[~, a] = max(test_y);
err=zeros(1,26);
for k=1:20800
    if h(k)~=a(k)
        err(a(k))=err(a(k))+1;
    end
end
err=err/800;