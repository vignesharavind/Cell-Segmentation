function [PixelIdxList,Canvas] = draw_solid_circles_ver2(BW3,radius,X,Y,indi)
Canvas = false(size(BW3));
imageSizeX = size(Canvas,2);
imageSizeY = size(Canvas,1);
[columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);

for kk2=1:length(indi)
    kk=indi(kk2,1);
    centerX = X(kk,1); centerY = Y(kk,1);
    circlePixels = (rowsInImage - centerY).^2 ...
        + (columnsInImage - centerX).^2 <= radius.^2;
    
    PixelIdxList{kk,1} = find(circlePixels==1);
end

% Draw circle and fill indices
for jj2=1:length(indi)
    jj=indi(jj2,1);
    Canvas(PixelIdxList{jj,1}) = 1;
end

figure; imshow(Canvas)
end