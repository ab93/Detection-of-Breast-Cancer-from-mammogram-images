
clc
close all
clear all
img= imread('mdb058.pgm');
img_median=medfilt2(img,[10,10]);  % apply median filter to the image
max_pixel=max(max(img_median));
min_pixel=min(min(img_median));
new_max_pixel=210;
new_min_pixel=60;
temp= (new_max_pixel - new_min_pixel)/(max_pixel - min_pixel);
normalize_img = (temp.*(img_median - min_pixel)) + new_min_pixel;  % normalize the image
threshold= graythresh(normalize_img);
%bw_img= im2bw(normalize_img,(threshold + .15)); %threshold the image
bw_img= im2bw(normalize_img,(threshold));
%bw_img= im2bw(normalize_img,0.67)
figure,imshow(img_median);
figure,imshow(bw_img);
%threshold
final_img = bwselect(bw_img);  %select the component of threshold
figure,imshow(final_img);

x = zeros(3,1); 

%size(normalize_img)
%size(img_median)
%size(bw_img)
%size(final_img,1)

I = normalize_img;  %set I as the normalized image
%I = img;
%final_img = imfill(final_img);

for i=1:size(final_img,1)     % iterate through the black-white image and find the coordinates of the white portions
    for j=1:size(final_img,2)
       I(i,j) = 0;
       if final_img(i,j) == 1
             final_img(i,j)
            x(1,end+1) = i;
            x(2,end) = j;
        end
    end
end


for j=2:size(x,2)
        x(3,j) = img(x(1,j),x(2,j));
        I(x(1,j),x(2,j)) = 60;
    
end

%x;
%RF = zeros(1024,1024);


for j=2:size(x,2)
        I(x(1,j),x(2,j)) = x(3,j);
%        x(3,j)
    
end

x1 = x(:,2:size(x,2));
max_dim = max(x,[],2);
min_dim = min(x1,[],2);

x_max = max_dim(1);
x_min = min_dim(1);
y_max = max_dim(2);
y_min = min_dim(2);

I_old = I;

for i=x_min:x_max
    for j=y_min:y_max
        I(i,j) = img(i,j);
    end
end

new_img = I(x_min:x_max,y_min:y_max);
old_img = I_old(x_min:x_max,y_min:y_max);

size(I)
%figure,imshow(I)
%figure,imshow(normalize_img)
figure,imshow(old_img)
figure,imshow(new_img)
imwrite(new_img,'output1/img058.jpg','jpg')
imwrite(new_img,'output2/img058.jpg','jpg')
        