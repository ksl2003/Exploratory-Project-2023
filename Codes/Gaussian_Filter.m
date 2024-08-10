% Implementing Gaussian Filter
clc;
close all;
img=imread("Lena_Monochrome.jpg");
%img=rgb2gray(img); %Only use if we want to denoise the coloured img
noised_Img = imnoise(my_img,'gaussian');
%Gaussian Kernel
sigma = 1; % Standard Deviation
kernel = zeros(5,5); % Kernel Established of size (5,5)
W=0;
for i = 1:5
 for j = 1:5
 sq_dist=(i-3)^2 + (j-3)^2;
 kernel(i,j) = kernel(i,j) + exp(-1 * (sq_dist)/(2*sigma*sigma)); %Normal Distribution
 W=W+kernel(i,j); % For Normalisation
 end
end
kernel=kernel/W; % Normalising the kernel
[m,n] = size(noised_Img);
output = zeros(m,n);
Im=padarray(noised_Img,[2,2]); % Padding is applied to image to not have the edge errors
for i = 1:m
 for j=1:n
 temp = Im(i:i+4 , j:j+4);
 temp = double(temp);
 conv = temp.*kernel; %Element wise multiplication with kernel
 output(i,j)=sum(conv(:));
 end
end
output = uint8(output);
%Computing the Peak Signal-to-Noise Ratio for Comparision with Original
%Image
psnr(output,img)
ssim(output,img)
kernel(:)
figure(1);
subplot(1,3,1); imshow(img); title('Original Image');
subplot(1,3,2); imshow(noised_Img); title('Guassian Noisy Image');
subplot(1,3,3); imshow(output); title('Gaussian Filter Applied Image');
