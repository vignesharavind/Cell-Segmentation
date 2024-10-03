%% Enhance contrast:
[fil,pth] = uigetfile({'*.tif';'*.tiff';'*.jpg';'*.jpeg'},'Select Image File');
I = imread([pth,fil]); 
%% Using histeq
figure;imshow(I); title('Original Image')
I1 = adapthisteq(I); figure;imshow(I1); title('Adaptive Histogram')
I2 = histeq(I); figure;imshow(I2); title('Equalizing Histogram')
I22 = histeq(I,250); figure;imshow(I22); title('Equalizing Histogram with value')
%% Using imadjust
I3 = imadjust(I); figure;imshow(I3); title('Using imadjust')
% Specify high and low values:
hh = 0.8; %high 
lw = 0.2; %Low 
I4 = imadjust(I,[lw hh],[]); figure;imshow(I4); title('Using imadjust values')
%figure;imshow(I);brighten(-0.8); title('Using brighten')
%% Save image equalizing histograms
svnme1 = ('Adaptive_Histogram.tif');
imwrite(I1,[pth,svnme1])
svnme2 = ('Hist.tif');
imwrite(I2,[pth,svnme2])
svnme22 = ('Hist_custom.tif');
imwrite(I22,[pth,svnme22])
%% Save only imadjust image
svnme3 = ('Imadjust.tif');
imwrite(I3,[pth,svnme3])
svnme4 = ('Imadjust_custom.tif');
imwrite(I4,[pth,svnme4])