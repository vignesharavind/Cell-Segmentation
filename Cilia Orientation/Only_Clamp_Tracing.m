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
again = true;
regionCount = 0;
while again
	promptMessage = sprintf('Draw region #%d in the upper right image,\nor Quit?', regionCount + 1);
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
X =[x1;x2];
Y =[y1;y2];
%% Get angles
%pathanme=('D:\Elena Images\Venkat\Control R1\Sample1\');
angle = zeros(size(x1));
for jj=1:length(x1)

x_c = x1(jj,1);
x_r = x2(jj,1);
y_c = y1(jj,1);
y_r = y2(jj,1);

%y2 is y1 y1 is y2 normal convention 0,0 bottom left; reverse direction
%     Y = y_r - y_c;
%     %Y = y_c - y_r;
%     X = x_c - x_r;
    
%y2 is y1 y1 is y2 normal convention 0,0 bottom left
    Y = y_c - y_r;
    X = x_r - x_c;

%y2 and y1 unchanged y flip condition top left 0,0
%     Y = y_r - y_c;
%     X = x_r - x_c;
    angle(jj,1) = atan2d(Y,X);
end
writematrix(angle,[path,'Angle_180_Foot.xlsx'])
save([path,'Data.mat'])
%% Polarhistogram
%theta = deg2rad(mal2);
%theta = -deg2rad(angle);
theta = deg2rad(angle);
figure;
h=polarhistogram(theta,10,'FaceColor','red');
%h=polarhistogram(theta,25,'FaceColor','red','FaceAlpha',0.1);
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
%Coreo2 = deg2rad(angle);
Coreo2 = -deg2rad(angle);
U1 = cos(Coreo2);
V1 = sin(Coreo2);
%
%figure; imshowpair(I1,J1);
figure; imshowpair(I1,I2)
hold on;
quiverC2D(x1,y1,U1,V1,'scale',1,'LineWidth', 2,'MaxHeadSize',2)
%set(gca, 'Color', 'white');
hold off;
%saveas(gcf,'D:\Elena Images\Venkat\Control R1\quiver_1.tif');
f=getframe;
h=f.cdata;
%set(gca,'YDir','reverse')
%set(gcf,'Position',get(0, 'Screensize'))
%imwrite(h,'D:\Elena Images\Venkat\Control R1\quiver.tif');
imwrite(h,[path,'quiver_foot.tif']);
%
figure; 
quiverC2D(x1,y1,U1,V1,'scale',1)
saveas(gcf,[path,'quiver_only2_foot.tif']);
%% Save what was saved
% Update num as needed
num=1;
save([path,'wip',num2str(num),'.mat'])
%% Visulaize saved work to continue
%load('D:\Embryo Tile Scans\Final Trials\Clamp\S1\Head\wip11.mat');
% 1) Run block 1; 2) Update num; 3) To continue run block 2 again
% num=1;
load(['wip',num2str(num),'.mat']);
figure;imshowpair(I1,I2)
for kk = 1:length(x1)
    if(~isempty(x1))
        h = drawline('Position',[x1(kk,1) y1(kk,1);x2(kk,1) y2(kk,1)],'StripeColor','r');
        hold on;
    end
end
%%
% angle2=zeros(size(angle));
% for uu=1:length(angle)
%     an=angle(uu,1);
%     if(an>0)
%         angle2(uu,1) = an-180;
%     else
%         angle2(uu,1) = 180-an;
%     end
% end
% Coreo22 = -deg2rad(angle2);
% UU1 = cos(Coreo22);
% VV1 = sin(Coreo22);
%%
% figure; 
% q=quiver(x1,y1,UU1,-VV1,'c');
% q.MaxHeadSize = 2;
% q.LineWidth = 2;
% q.AutoScaleFactor = 1;
% set(gca,'YDir','reverse')
%saveas(gcf,[path,'quiver_only2_foot.tif']);