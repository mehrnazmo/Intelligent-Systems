***********************************************
Directional Image Filtering
**********************************************************

Gabor filters are useful filters for finding directionality in images. They’re often used for texture extraction. 

This problem is a straight forward application of filtering in images and inspecting the magnitude responses in the Fourier Domain.



There are three variables in data.mat:
-the image to be filtered
-a 65*65*4 set of kernels
-a 1 × 4 array of orientations each corresponding to a filter.



In this problem we illustrate the original image along with the filtered image.