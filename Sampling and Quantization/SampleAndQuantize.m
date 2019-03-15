function [sampled_image,quantized_5levels,quantized_3levels] = SampleAndQuantize(name)
%This function gets the name of an image file and returns the sampled and
%quantized versions of the input image
%Inputs
%name::name of the image file
%Outputs
%sampled:: original image sampled spatially by 8
%quantized_5levels:: 5-level quantized version of 'sampled'
%quantized_3levels:: 3-level quantized version of 'sampled'
%% 
image1 = imread(name);
imshow(image1);
%Sampling
sampled_image = image1(1:8:end,1:8:end);
figure();
imshow(sampled_image);
%5-level quantization
quant5 = 256/5;
quantized_5levels = (2*(sampled_image/quant5)+1)*quant5;
figure();
imshow(quantized_5levels);
%3-level quantization
quant3 = 256/3;
quantized_3levels = (2*(sampled_image/quant3)+1)*quant3;
figure();
imshow(quantized_3levels);

end

