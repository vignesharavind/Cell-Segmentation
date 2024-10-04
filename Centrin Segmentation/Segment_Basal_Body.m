[file1,path1] = uigetfile({'*.tif';'*.tiff';'*.jpg';'*.png'},'Select membrane image');
I = imread([path1,file1]);
SE = strel('disk',10);
I1 = imtophat(I,SE);
h = imbinarize(I1);
mask = roipoly(h);
h(~mask)=0;
figure;imshow(h)
h1 = quantumwatershed(h);