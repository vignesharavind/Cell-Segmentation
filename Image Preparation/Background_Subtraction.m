%% Background Subtraction:
[fil,pth] = uigetfile({'*.tif';'*.tiff';'*.jpg';'*.jpeg'},'Select Image File');
I = imread([pth,fil]); 
%%
figure;imshow(I)
% I2 = imnoise(I,'salt & pepper',0.02);
% figure;imshow(I2)
I2 = histeq(I);
figure;imshow(I2)
%%
sz=49; %Size of window -1
h = drawrectangle('Position',[10,10,sz,sz],'Color','c');
pos = customWait(h);
Icrop=imcrop(I2,pos);
crp_avg=mean2(Icrop);
Isub = I2 - crp_avg;
figure;imshow(Isub)
%% Save subtracted image
imwrite(Isub,[pth,'I_Subtracted.tif'])