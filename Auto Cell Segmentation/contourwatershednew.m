function h4 = contourwatershednew(h3,n)
D = -bwdist(~h3);
imshow(D,[])
Ld = watershed(D);
figure;imshow(label2rgb(Ld))
mask = imextendedmin(D,n); %Default value is 2
%mask = imextendedmin(D,5);
imshowpair(h3,mask,'blend')
D2 = imimposemin(D,mask);
Ld2 = watershed(D2);
h4=h3;
h4(Ld2 == 0) = 0;
imshow(h4)
end
