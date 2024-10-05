%% Select and read images:
% I1 = imread('D:\Embryo Tile Scans\Final Trials\Clamp\S1\Head\Resized_Flip_Clamp.tif');
% I2 = imread('D:\Embryo Tile Scans\Final Trials\Clamp\S1\Head\Resized_Flip_Centrin.tif');
[file,path] = uigetfile({'*.tif';'*.tiff';'*.jpg';'*.jpeg'},'Select Clamp Image');
[file2,path2] = uigetfile({'*.tif';'*.tiff';'*.jpg';'*.jpeg'},'Select Centrin Image');
I1 = imread([path,file]); I2 = imread([path2,file2]);
figure;imshowpair(I1,I2)
%...........................................................................................................................................................
% BLOCK 1:
%...........................................................................................................................................................
% [file1,path1] = uigetfile({'*.tif';'*.tiff';'*.jpg';'*.png'},'Select clamp image');
% I1 = imread([path1,file1]);
% [file2,path2] = uigetfile({'*.tif';'*.tiff';'*.jpg';'*.png'},'Select centrin image');
% I2 = imread([path2,file2]);
% figure;imshowpair(I1,I2)
%% Main Tracing Code
%...........................................................................................................................................................
% BLOCK 2:
%...........................................................................................................................................................
loop = true;
if(~exist('Cellcount','Var'))
    Cellcount = 0;
end
while loop
    promptMessage = sprintf('Ready to start the loop #%d,\nor Quit?', Cellcount + 1);
    titleBarCaption = 'Continue?';
    button = questdlg(promptMessage, titleBarCaption, 'Continue', 'Quit', 'Continue');
    if strcmpi(button, 'Quit')
        break;
    end
    Cellcount =Cellcount+1;
    %...........Trace Clamp now.............................................................................................................................................
    again = true;
    regionCount = 0;
    while again
        promptMessage = sprintf('Draw lines (cyan) #%d in the current cell,\nor Quit?', regionCount + 1);
        titleBarCaption = 'Continue?';
        button = questdlg(promptMessage, titleBarCaption, 'Draw', 'Quit', 'Draw');
        if strcmpi(button, 'Quit')
            break;
        end
        regionCount = regionCount + 1;
        %[thisSinglePolygonImage, xi, yi] = roipoly();
        roi = drawline;
        x1(regionCount,1) = roi.Position(1,1);
        x2(regionCount,1) = roi.Position(2,1);
        y1(regionCount,1) = roi.Position(1,2);
        y2(regionCount,1) = roi.Position(2,2);
    end
    X1{Cellcount,1} =[x1];
    X2{Cellcount,1} =[x2];
    Y1{Cellcount,1} =[y1];
    Y2{Cellcount,1} =[y2];
    clear x1 x2 y1 y2
    
    promptMessage = sprintf('Now draw the outline of current cell #%d (red),\nor Quit?', Cellcount);
    titleBarCaption = 'Draw MCC';
    button = questdlg(promptMessage, titleBarCaption, 'Draw','Draw');

    %...........Trace MCC Now.............................................................................................................................................
    p = drawpolygon('LineWidth',2,'Color','magenta');
    [centroids] = p.Position;
    xi{Cellcount,1} = centroids(:,1);
    yi{Cellcount,1} = centroids(:,2);
    clear p centroids   
end
%% Save what was saved
% Update num as needed
num=1;
save([path,'wip',num2str(num),'.mat'],'X1','X2','Y1','Y2','xi','yi','Cellcount')
%% Visulaize saved work to continue
% 1) Run block 1; 2) Update num; 3) To continue run block 2 again
% num=1;
load([path,'wip',num2str(num),'.mat']);
figure;imshowpair(I1,I2)

for kk = 1:length(xi)
    for ll = 1:length(X1{kk,1})
        if(~isempty(X1{kk,1}))
            h = drawline('Position',[X1{kk,1}(ll,1) Y1{kk,1}(ll,1);X2{kk,1}(ll,1) Y2{kk,1}(ll,1)],'StripeColor','r');
            hold on;
        end
    end
    if(~isempty(X1{kk,1}))
        clear h
        p = drawpolygon('Position',[xi{kk,1},yi{kk,1}],'LineWidth',2,'Color','magenta');
        hold off;
        clear p
    end
end
%% Remove vector:
% wip11.mat (remove 32)
% wip5.mat (remove 12)
%rmvec = 12;
mvec = [12,32];
for bb=1:length(mvec)
    rmvec = mvec(1,bb);
    X1{rmvec,1}=[]; X2{rmvec,1}=[];
    Y1{rmvec,1}=[]; Y2{rmvec,1}=[];
    xi{rmvec,1}=[]; yi{rmvec,1}=[];
end
%% Get angles
%pathanme=('D:\Elena Images\Venkat\Control R1\Sample1\');
angle = zeros(size(X1));
for kk=1:length(xi)
    for jj=1:length(X1)

        x_c = X1{kk,1}(jj,1);
        x_r = X2{kk,1}(jj,1);
        y_c = Y1{kk,1}(jj,1);
        y_r = Y2{kk,1}(jj,1);

        %y2 is Y1 Y1 is y2 normal convention 0,0 bottom left; reverse direction
        %     Y = y_r - y_c;
        %     %Y = y_c - y_r;
        %     X = x_c - x_r;

        %y2 is Y1 Y1 is y2 normal convention 0,0 bottom left
        Y = y_c - y_r;
        X = x_r - x_c;

        %y2 and Y1 unchanged y flip condition top left 0,0
        %     Y = y_r - y_c;
        %     X = x_r - x_c;
        angle(jj,1) = atan2d(Y,X);
    end
    Master_Angle(:,kk)=angle;
end
writematrix(Master_Angle,[path,'Angle_180_Foot.xlsx'])
save([path,'Data.mat'])
%% Polarhistogram
figure;
h=polarhistogram(deg2rad(Master_Angle(:,1)),10,'FaceColor','red');
hold on;
h2=polarhistogram(deg2rad(Master_Angle(:,2)),10,'FaceColor','blue','FaceAlpha',0.5);
set(h,{'linew'},{2})
%h.DisplayStyle = 'stairs';
ax2=gca;
box on;
ax2.FontWeight = 'bold';
ax2.FontSize=25;
%ax2.ThetaDir = 'clockwise';
% ax2.XAxis.FontSize = 15;
% ax2.YAxis.FontSize = 20;
set(ax2,'LineWidth',4)
set(ax2, 'FontName', 'Arial')
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,[path,'polarhistogram_1.jpg']);
%%
cd('D:\MATLAB Projects 3_17_24\Image Segmentation\Clamp Orientation\Clamp Orientation\Circ_Stat\')
obj1 = CircHist(deg2rad(Master_Angle(:,1)),10);
cd('D:\MATLAB Projects 3_17_24\Image Segmentation\Clamp Orientation\')
%% Cell properties:
Fin = false(size(I1));
for kk =1:length(xi)
    mask = roipoly(Fin, xi{kk,1}, yi{kk,1});
    Fin(mask)=1;
end
figure; imshow(Fin)
%% Polt and save cell features:
pf = 0.0710227; %Pixel to micron ratio
Ver2_plot_allcell_props(Fin,pf,path)