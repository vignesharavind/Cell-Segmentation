function Img9 = V2_allcellseg(BW,fudgeFactor,maxin)
%
Img2 = bwareaopen(BW,25);
figure; imshow(Img2)

[~, X] = edge(Img2, 'sobel');
Img3 = edge(Img2,'sobel', X * fudgeFactor);
figure; imshow(Img3)
%
Img4 = imcomplement(Img3);

figure; imshow(Img4)

Img5 = contourwatershednew(Img4,maxin);
figure; imshow(Img5)

Img6 = bwareaopen(Img5, 20);
figure; imshow(Img6);

Img7 = imfill(Img6, 'holes');
figure; imshow(Img7);

Img88 = imerode(Img7,strel('disk',1));
figure; imshow(Img88)

Img8 = imopen(Img88,strel('disk',2));
figure; imshow(Img8)

Img9 = bwareaopen(Img8,100);
figure; imshow(Img9)

close all;
end
