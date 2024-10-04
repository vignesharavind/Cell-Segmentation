%% Centrin Segmentation:
%cd('D:\MATLAB Projects 3_17_24\Image Segmentation\Centrin Segmentation') % Code Location 
[file,path] = uigetfile({'*.tif';'*.tiff';'*.jpg';'*.jpeg'},'Select Image');
II1 = imread([path,file]);
figure; imshow(II1)
mask=roipoly;
II1(~mask)=0;
thrsh =0.3;
BW = findthresh_IFT_ver2(II1,thrsh);
figure;imshow(BW)
promptMessage = ('Do you want to change threshold?');
titleBarCaption = 'Yes/No?';
button2 = questdlg(promptMessage, titleBarCaption, 'Yes', 'No', 'Yes');
while(strcmpi(button2, 'yes'))
    close all;
    thrsh = input('Enter threshold value: ');
    BW = findthresh_IFT_ver2(II1,thrsh);
    figure;imshow(BW)
    figure; imshowpair(II1,BW)
    promptMessage = ('Try another threshold?');
    titleBarCaption = 'Yes/No?';
    button2 = questdlg(promptMessage, titleBarCaption, 'Yes', 'No', 'Yes');
end
close all;clc
imwrite(BW,[path,'Segmented_Centrin.tif']);
figure; imshowpair(II1,BW)
RR = bwconncomp(BW);
Num = RR.NumObjects