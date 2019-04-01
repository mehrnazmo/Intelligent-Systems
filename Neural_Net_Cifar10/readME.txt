***********************************************
CNN network for CIFAR-10:

*******************************************************************
In this project, we will train a convolutional neural network (ConvNet) for an image classification task and use the trained model for detecting images in the CIFAR-10 dataset provided by https://www.cs.toronto.edu/~kriz/cifar.html.

"extractCifar10" function provides us with the CIFAR-10 dataset.

Then we define our 16 layer neural network to classify the images in 10 categories. The network includes convolutional, batch normalization, relu, max pooling, fully connected, softmax and classification layers.


Training parameters:
initial learning rate:0.001
Epochs: 20
Mini batch size: 128
