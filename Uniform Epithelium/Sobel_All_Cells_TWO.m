% Read image:
[file1,path1] = uigetfile({'*.tif';'*.tiff';'*.jpg';'*.png'},'Select membrane image');
I = imread([path1,file1]);
%% If noisy run this section:
II = adapthisteq(I);
figure; imshow(II)
thrsh=2; %Use values between (2-3) for noisy image 
inx=II<thrsh*mean2(II);
II(inx)=0; figure;imshow(II)
%% Binarize:
BW = imbinarize(II, 'adaptive', 'Sensitivity', 0.00000, 'ForegroundPolarity', 'bright');
figure; imshow(BW)
%% Watershed
fudgeFactor = 1; %Higher fudgefactor includes only stronger signals. 0 everything even lower signals or noise
%maxin = 20; %Use smaller maxin (4-10) for smaller cells or lower zoom with lots of cells
maxin = 16;
Iseg = V2_allcellseg(BW,fudgeFactor,maxin);
figure;imshowpair(Iseg,I,'montage')
%% Edges
h6 = imcomplement(logical(Iseg));
h7 = bwskel(logical(h6));
figure;imshow(h7)
h8 = uint8(h7.*255);
figure;imshow(h8)
figure;imshowpair(Iseg,h8)
figure;imshowpair(I,h8)