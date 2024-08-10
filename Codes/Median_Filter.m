%% Median filter
% original image
my_img=imread('../Images/Lena_Monochrome.jpg');
subplot(1,4,1); imshow(my_img); title('My Original Image');
% salt & pepper
%ig=rgb2gray(my_img);
noised_Img = imnoise(my_img,'salt & pepper');
subplot(1,4,2); imshow(noised_Img); title('Noisy Image');
% median filtering
img_med_2=median_filter(noised_Img);
subplot(1,4,3); imshow(img_med_2); title('Median Filtered Image');
%Calculating the metrics
psnr(img_med_2,my_img)
ssim(img_med_2,my_img)
function gr = median_filter(image)
 gr = image;
 Lint = 1;
 Pint = 1;
 % Lines
 for l = Lint+1 : size(image,1)-Lint
   % Pixels
   for p = Pint+1 : size(image,2)-Pint
     % Extract of sub-image (window)
     window = image(l-Lint : l+Lint, p-Pint : p+Pint); % It will create a subimage of size (3x3) for the image located at (l,p).
     [n1,n2] = size(window); 
     vector = zeros(n1*n2); 
     i = 1; 
     for j = 1 : n1
       for k = 1 : n2
        vector(i) = window(j,k);
        i = i + 1;
       end
     end
     sorted = sort(vector);
     % convolution between sub-image and mask
     gr(l,p) = sorted(fix(length(sorted)/2) + 1); % We are trying to take the median value of the neighbouring pixels intensity.
    end
  end
end
