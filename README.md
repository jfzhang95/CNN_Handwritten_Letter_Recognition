# mathematics_experiment


tat.m用emnist-letters.mat中的训练集和测试集训练神经网络，最后会显示准确率。需要存储网络的话可将工作区中cnn保存为mat文件。

predict.m是被gui调用的预测函数。它会调用已经训练好的cnn.mat。输入图片路径，输出识别字母和识别准确率。

其余文件不被直接调用，均在训练或测试中调用，详细作用可以看文件中的注释。
