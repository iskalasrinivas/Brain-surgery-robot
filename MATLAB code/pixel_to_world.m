function markers_cam = pixel_to_world(centroids, KK, Z)
% Function pixel_to_world converts the pixel co-ordinates to the camera
% co-ordinates. 
% It takes in centroids of the three markers as a 3x2 matrix, the camera
% instrinsic KK and actual distance from the camera to the markers Z and 
% returns the position of the markers in a 3x2 matrix

%%%%%%%%%%%%%%%%%%% YOUR CODE BELOW THIS LINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
px1=centroids(1,1);
py1=centroids(1,2);
px2=centroids(2,1);
py2=centroids(2,2);
px3=centroids(3,1);
py3=centroids(3,2);
xc1=-((px1-KK(1,3))*Z)/KK(1,1);
yc1=-((py1-KK(2,3))*Z)/KK(2,2);
xc2=-((px2-KK(1,3))*Z)/KK(1,1);
yc2=-((py2-KK(2,3))*Z)/KK(2,2);
xc3=-((px3-KK(1,3))*Z)/KK(1,1);
yc3=-((py3-KK(2,3))*Z)/KK(2,2);

markers_cam = zeros(3,2);
markers_cam=[xc1 yc1;xc2 yc2;xc3 yc3]
end