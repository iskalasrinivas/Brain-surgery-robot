%% This script finds the centre locations of the targets and plots them on the image
%% 1; Reading Image and converting to grayscale 
imgT = imread('Targets, cropped.png');
im_gT = rgb2gray(imgT);
dispIm(im_gT)

%% 2; Applying Noise Removal and contrast enhancement
img_cleanT = medfilt2(im_gT,[3 3]);
img_contrastT = imadjust(img_cleanT);

% 3; Sharpening image
img_sharpT = imsharpen(img_contrastT);
dispIm(img_sharpT)

%% 4; Removing spots below a certain gray threshold
bw_1T = img_sharpT > 150;
dispIm(bw_1T)

%% 5; Using the region properties to isolate circular blobs
[m,n] = size(bw_1T);
labelT = bwlabel(bw_1T);
statsT = regionprops(logical(bw_1T), 'Area', 'Centroid', 'Eccentricity');
bw_2T = false(m,n);
for n = 1:length(statsT)
    if statsT(n).Eccentricity < 0.6
        bw_2T(labelT == n) = 1;
    end
end
dispIm(bw_2T)

%% 6; Using dilation to complete circularity
structelemT = strel('disk',1);
bw_3T = imdilate(bw_2T, structelemT);

%% Getting the centroids of the isolated circular blobs
label2T = bwlabel(bw_3T);
stats2T = regionprops(logical(bw_3T),'Centroid');
centrsT = ones(3,2);
for n = 1:3
    centrsT(n,:) = stats2T(n).Centroid;
end
%% 7; Plotting the centroid positions with circles on top of the image
dispIm(im_gT)
hold on
scatter(centrsT(1,1),centrsT(1,2),350,'or','LineWidth',1.5)
scatter(centrsT(2,1),centrsT(2,2),75,'or','LineWidth',1.5)
scatter(centrsT(3,1),centrsT(3,2),150,'or','LineWidth',1.5)
plot(centrsT(:,1),centrsT(:,2),'b+','LineWidth',1.5)
centrsT


