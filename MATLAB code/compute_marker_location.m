function centroids = compute_marker_location(img)
% Function compute_marker_location takes in a img(uint8 format) as an input argument 
% and returns the centroids of the three markers as a 3x2 array.
% Perform necessary image processing operations to get the location of the
% centroids

%%%%%%%%%%%%%%%%%%%% YOUR CODE BELOW THIS LINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Image segmentation

% Converts rgb image to hsv color space
img_hsv= rgb2hsv(img);
ans = (img_hsv(:,:,3)<0.55) & (img_hsv(:,:,3)>0.1) ....
    & (img_hsv(:,:,2)<0.93) & (img_hsv(:,:,2)>0.3) ....
    & (img_hsv(:,:,1)<0.3) & (img_hsv(:,:,1)>0.01);
bw_2=bwareaopen(ans,50);
bw_3=bwconncomp(bw_2);
label = bwlabel(bw_2);
stats=regionprops(bw_3,'Area','Eccentricity');

idx= find([stats.Area]<110&[stats.Eccentricity]<0.65);
bw_3= ismember(labelmatrix(bw_3),idx);

structelem = strel('disk',3);
bw_4 = imdilate(bw_3, structelem)

label2 = bwlabel(bw_4);
stats2 = regionprops(logical(bw_4),'Centroid');

[a,b]= size(stats2);
centroids=zeros(a,b);
for d=1:length(stats2)
    x=stats2(d).Centroid;
    centroids(d,1)=x(1,1);
    centroids(d,2)=x(1,2);
end

figure
% Plot the contours and the centroids of the markers on the image
imshow(img)
hold on
% bwperim(bw_4);

 perim = bwperim(bw_4,8); %// Get perimeter of the mask
 red = img(:,:,1); %// Extract the colour planes of the original image
 green = img(:,:,2);
 blue = img(:,:,3);
 red(perim) = 255; %// Set those pixels in the perimeter to yellow
 green(perim) = 255;
 blue(perim) = 0;
 out = cat(3, red, green, blue); %// Make an output image
 imshow(out);

%hold on
plot(centroids(:,1),centroids(:,2),'r+','markersize',5);


end