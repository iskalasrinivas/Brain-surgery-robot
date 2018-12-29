%% This script finds the centre locations of the fiducials and plots them on the image
%% 1; Reading Image and converting to grayscale 
imgF = imread('Fiducials, cropped.png');
im_gF = rgb2gray(imgF);
dispIm(im_gF)

%% 2; Applying Noise Removal and contrast enhancement
img_cleanF = medfilt2(im_gF,[3 3]);
img_contrastF = imadjust(img_cleanF);

% 3; Sharpening image
img_sharpF = imsharpen(img_contrastF);
dispIm(img_sharpF)

%% 4; Removing spots below a certain gray threshold
bw_1F = img_sharpF > 254;
dispIm(bw_1F)

%% 5; Removing blobs below a defined area
bw_2F = bwareaopen(bw_1F,170);
dispIm(bw_2F)

%% 6; Using the region properties to isolate circular blobs and remove others
[m,n] = size(im_gF);
labelF = bwlabel(bw_2F);
statsF = regionprops(logical(bw_2F), 'Area', 'Centroid', 'Eccentricity');
bw_3F = false(m,n);
for n = 1:length(statsF)
    if statsF(n).Eccentricity < 0.77 && statsF(n).Area ~= 187 && statsF(n).Area ~= 186
        bw_3F(labelF == n) = 1;
    end
end
dispIm(bw_3F)

%% 7; Using dilation to complete circularity and enlarge
structelemf = strel('disk',3);
bw_4F = imdilate(bw_3F, structelemf);

%% Getting the centroids of the isolated circular blobs
label2F = bwlabel(bw_4F);
stats2F = regionprops(logical(bw_4F),'Centroid');
centrsF = ones(3,2);
for n = 1:3
    centrsF(n,:) = stats2F(n).Centroid;
end
%% 8; Plotting the centroid positions with circles on top of the image
dispIm(im_gF)
hold on
scatter(centrsF(:,1),centrsF(:,2),120,'or','LineWidth',1.5)
plot(centrsF(:,1),centrsF(:,2),'b+','LineWidth',1.5)
centrsF

