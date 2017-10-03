function [Yy right t1]=predict(a)
%x是图片的名字，需要加单引号。使用该函数时请将cnn.mat和所需预测的图像放在相同路径中
t0 = cputime;
load('cnn.mat');
net=cnn;
if length(size(a))==3
    b=rgb2gray(a);
else
    b=a;
end
b=medfilt2(b,[5,5]);%滤波
siz=size(b);
ax=[0,0];in=siz;
for i=6:siz(1)-5
    for j=6:siz(2)-5
        if b(i,j)<1
            if i>ax(1)
                ax(1)=i;
            end
            if i<in(1)
                in(1)=i;
            end
            if j>ax(2)
                ax(2)=j;
            end
            if j<in(2)
                in(2)=j;
            end
        end
    end
end
c=imresize(b(in(1):ax(1),in(2):ax(2)),[20,18]);
d=255+zeros(28,28,2);
d(5:24,6:23,1)=c;
d=1-d/255;
d(:,:,2)=zeros(28,28);
net = cnnff(net, d);
[~,h] = max(net.o);
tmp=sort(net.o(:,1),'descend');
right=tmp(1)/sum(tmp(1:3));
if h(1)<=26
    Yy=char(h(1)+64);
else
    Yy=char(h(1)+70);
end
t1 = cputime-t0;
end

