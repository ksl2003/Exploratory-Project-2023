% Implementing Gaussian Filter
clc;
close all;
img=imread("../Images/Lena_Monochrome.jpg");
% img=rgb2gray(img); Only use if we want to denoise the coloured img
noised_Img = imnoise(img,'salt & pepper');
% Applying Mean Filter 
kernel = zeros(3,3); % Kernel Established of size (5,5)
for i = 1:3
 for j = 1:3
 kernel(i,j) = 1/9;
 end
end
[m,n] = size(noised_Img);
output = zeros(m,n);
Im=padarray(noised_Img,[2,2]); % Padding is applied to image not to have the edge errors
for i = 1:m
 for j=1:n
 temp = Im(i:i+2 , j:j+2);
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
subplot(1,3,2); imshow(noised_Img); title('Noisy Image');
subplot(1,3,3); imshow(output); title('Mean Filter Applied Image');
