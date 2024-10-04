%% Load sectionwise data to visualize
%load('D:\Cilia Map\Image Segmentation\Embryo Map\Section Embryos\Final Trials\Validation Trial4\S1\FinalTailTrial4Sample1.mat');
[file1,path1] = uigetfile({'*.tif';'*.tiff';'*.jpg';'*.png'},'Select membrane image');
I1 = imread([path1,file1]);
[file2,path2] = uigetfile({'*.tif';'*.tiff';'*.jpg';'*.png'},'Select cilia image');
I2 = imread([path2,file2]);
%% Draw MCC
figure; imshowpair(I1,I2)
%figure; imshow(I2)
again = true;
regionCount = 1;
while again
	promptMessage = sprintf('Trcae MCC Cell #%d ,\nor Quit?', regionCount);
	titleBarCaption = 'Continue?';
	button = questdlg(promptMessage, titleBarCaption, 'Draw', 'Quit', 'Draw');
	if strcmpi(button, 'Quit')
		break;
    end
    p = drawpolygon('LineWidth',2,'Color','cyan');
    %[thisSinglePolygonImage, xi, yi] = roipoly();
    %[~, xi{regionCount,1}, yi{regionCount,1}] = roipoly();
    [centroids] = p.Position;
    %cent{regionCount,1} = centroids;
    xi{regionCount,1} = centroids(:,1);
    yi{regionCount,1} = centroids(:,2);
    clear centroids
    regionCount = regionCount + 1;
end
%%
Fin = false(size(I1));
for kk =1:length(xi)
    mask = roipoly(Fin, xi{kk,1}, yi{kk,1});
    %mask = roipoly(Fin, xold{kk,1}, yold{kk,1});
    Fin(mask)=1;
end

figure; imshow(Fin)
%% Get region properties:
pf=0.44;
Ver2_plot_allcell_props(Fin,pf,path1)
RR = regionprops(Fin,'all');
save([path2,'All_Properties.mat'],'RR')
%% Remove vectors if needed
rmvec1 = [4];
for jj=1:length(rmvec1)
    cc=rmvec1(jj);
    xi{cc,1}=[];
    yi{cc,1}=[];
end
%% Save work in progress
save('Attempt1.mat')
%% Continue WIP
load('Attempt1.mat')
%
figure; imshowpair(I1,I2)
for ll=1:regionCount-1
    if(~isempty(xi{ll,1}))
        drawpolygon('Position',[xi{ll,1},yi{ll,1}],'LineWidth',2,'Color','cyan');
        hold on;
    end
end
hold off;
%% Continue working:
while again
	promptMessage = sprintf('Trcae MCC Cell #%d ,\nor Quit?', regionCount);
	titleBarCaption = 'Continue?';
	button = questdlg(promptMessage, titleBarCaption, 'Draw', 'Quit', 'Draw');
	if strcmpi(button, 'Quit')
		break;
    end
    p = drawpolygon('LineWidth',2,'Color','cyan');
    %[thisSinglePolygonImage, xi, yi] = roipoly();
    %[~, xi{regionCount,1}, yi{regionCount,1}] = roipoly();
    [centroids] = p.Position;
    %cent{regionCount,1} = centroids;
    xi{regionCount,1} = centroids(:,1);
    yi{regionCount,1} = centroids(:,2);
    clear centroids
    regionCount = regionCount + 1;
end