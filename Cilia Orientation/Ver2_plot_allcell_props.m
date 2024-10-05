function Ver2_plot_allcell_props(I6,pf,pathname)
Centroid = regionprops(I6,'Centroid');
C = [Centroid.Centroid].';
centroidsX = C(1:2:end-1);  
centroidsY = C(2:2:end);
Pixel = regionprops(I6,'PixelIdxList');
Oreo = regionprops(I6,'Orientation');
O = [Oreo.Orientation].';
Length = regionprops(I6,'MajorAxisLength');
L = [Length.MajorAxisLength].';
Width =  regionprops(I6,'MinorAxisLength');
W = [Width.MinorAxisLength].';
Aspect = L./W;
Ar =regionprops(I6,'Area');
Are=[Ar.Area].';
Area =[Are].*(pf^2);
Circle = regionprops(I6,'Circularity');
Cir = [Circle.Circularity].';
xend = size(I6,2);
yend = size(I6,1);
%% Visualize Orientation Colormaps
%Arrangle angles into bins
%O =O(filt);
[~,~,idx] = histcounts(O,-91:91);
% Paint the pixels with corresponding bins
L1 = zeros(size(I6));
%Identifier = 1:1:length(List); %Change here based on groups...............
for ii = 1:length(O)
    L1(Pixel(ii).PixelIdxList) = idx(ii);    %fill in indices
end
%% Colorplot Orientation
figure1 = figure('Colormap',...
        [0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 0.9375;0.125 1 0.875;0.1875 1 0.8125;0.25 1 0.75;0.3125 1 0.6875;0.375 1 0.625;0.4375 1 0.5625;0.5 1 0.5;0.5625 1 0.4375;0.625 1 0.375;0.6875 1 0.3125;0.75 1 0.25;0.8125 1 0.1875;0.875 1 0.125;0.9375 1 0.0625;1 1 0;1 0.899999976158142 0;1 0.800000011920929 0;1 0.699999988079071 0;1 0.600000023841858 0;1 0.5 0;1 0.400000005960464 0;1 0.300000011920929 0;1 0.200000002980232 0;1 0.100000001490116 0;1 0 0;0.964285731315613 0 0;0.928571403026581 0 0;0.892857134342194 0 0;0.857142865657806 0 0;0.821428596973419 0 0;0.785714268684387 0 0;0.75 0 0;0.714285731315613 0 0;0.678571403026581 0 0;0.642857134342194 0 0;0.607142865657806 0 0;0.571428596973419 0 0;0.535714268684387 0 0;0.5 0 0]);
%Lrgb = label2rgb(L1);
Lrgb = label2rgb(L1);
% Setting up axis
axes1 = axes('Parent',figure1,'YDir','reverse','Layer','top','CLim',[-91 91]);
%axes1 = axes('Parent',figure1,'YDir','reverse','Layer','top','CLim',[min(O)-1 max(O)+1]);
%Lim = caxis;
%caxis([1 5])
set(axes1,'TickLength',[0 0]);
%..............................................................................
%           xlim auto;
%           ylim auto;
%T1_S4.........................................................................
%         xlim(axes1,[0.5 6311.5]);
%         ylim(axes1,[0.5 2467.5]);
%T1_S5.........................................................................
%         xlim(axes1,[0.5 6197.5]);
%         ylim(axes1,[0.5 2542.5]);
%T2_S2.........................................................................
%         xlim(axes1,[0.5 5487.5]);
%         ylim(axes1,[0.5 2163.5]);
%T2_S4.........................................................................
%         xlim(axes1,[0.5 5439.5]);
%         ylim(axes1,[0.5 2251.5]);
%T3_S3.........................................................................
%        xlim(axes1,[0.5 6004.5]);
%        ylim(axes1,[0.5 2561.5]);
%T3_S4.........................................................................
         % xlim(axes1,[0.5 6318.5]);
         % ylim(axes1,[0.5 2555.5]);
%Axolotl S4.....................................................................
         % xlim(axes1,[0.5 6940.5]);
         % ylim(axes1,[0.5 2389.5]);
%Axolotl S7.....................................................................
         % xlim(axes1,[0.5 6017.5]);
         % ylim(axes1,[0.5 2390.5]);
%Laevis S9.....................................................................
         % xlim(axes1,[0.5 4649.5]);
         % ylim(axes1,[0.5 1936.5]);
%Laevis S10.....................................................................
         % xlim(axes1,[0.5 4654.5]);
         % ylim(axes1,[0.5 2281.5]);         
%...............................................................................
         xlim(axes1,[0.5 xend]);
         ylim(axes1,[0.5 yend]);

        box(axes1,'on');
        hold(axes1,'all');
        % Create image
        image(Lrgb,'Parent',axes1,'CDataMapping','scaled');
        %image(L,'Parent',axes1,'CDataMapping','scaled');
        % Create colorbar
        colorbar('peer',axes1);
        %box on;
           % code
        %set(axes1,'XTick',[], 'YTick', [])
        % gca = ax
        %set(axes1,'xticklabel',[])
        title('Orientation (degrees)','FontSize', 15, 'Color', 'black', 'FontWeight', 'bold')
        set(axes1,'TickLength',[0 0],'LineWidth',2,'XTick',[],'YTick',[]);
        %set(axes1,'TickLength',[0 0],'LineWidth',2,'XTick',[],'YTick',[],'xticklabel',[],'yticklabel',[]);
        yyaxis right
        ylabel ('Orientation','FontSize', 15, 'Color', 'black', 'FontWeight', 'bold')
        k = [0, 0, 0];
        axes1.YColor = k;%
        %set(axes1,'YTick',[],'yticklabel',[]);
        set(axes1,'YTick',[]);
        set(gcf,'Position',get(0,'Screensize'))
        saveas(figure1,[pathname,'Orientation.tif']);
%% Visualize Aspect Ratio Colormaps
%Arrangle angles into bins
%Aspect = Aspect(1:end-5,1);
edges = 0:0.5:4;
[~,~,bins] = histcounts(Aspect,edges);
% Paint the pixels with corresponding bins
L2 = zeros(size(I6));
%Identifier = 1:1:length(List); %Change here based on groups...............
for ii = 1:length(Aspect)
    L2(Pixel(ii).PixelIdxList) = bins(ii);    %fill in indices
end
%% Colorplot Aspect Ratio
figure2 = figure('Colormap',...
        [0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 0.9375;0.125 1 0.875;0.1875 1 0.8125;0.25 1 0.75;0.3125 1 0.6875;0.375 1 0.625;0.4375 1 0.5625;0.5 1 0.5;0.5625 1 0.4375;0.625 1 0.375;0.6875 1 0.3125;0.75 1 0.25;0.8125 1 0.1875;0.875 1 0.125;0.9375 1 0.0625;1 1 0;1 0.899999976158142 0;1 0.800000011920929 0;1 0.699999988079071 0;1 0.600000023841858 0;1 0.5 0;1 0.400000005960464 0;1 0.300000011920929 0;1 0.200000002980232 0;1 0.100000001490116 0;1 0 0;0.964285731315613 0 0;0.928571403026581 0 0;0.892857134342194 0 0;0.857142865657806 0 0;0.821428596973419 0 0;0.785714268684387 0 0;0.75 0 0;0.714285731315613 0 0;0.678571403026581 0 0;0.642857134342194 0 0;0.607142865657806 0 0;0.571428596973419 0 0;0.535714268684387 0 0;0.5 0 0]);
%Lrgb = label2rgb(L1);
Lrgb = label2rgb(L2);
% Setting up axis
axes1 = axes('Parent',figure2,'YDir','reverse','Layer','top','CLim',[0 5]);
%axes1 = axes('Parent',figure2,'YDir','reverse','Layer','top');
Lim = caxis;
caxis([1 5])
set(axes1,'TickLength',[0 0]);
%..............................................................................
%           xlim auto;
%           ylim auto;
%T1_S4.........................................................................
%         xlim(axes1,[0.5 6311.5]);
%         ylim(axes1,[0.5 2467.5]);
%T1_S5.........................................................................
%         xlim(axes1,[0.5 6197.5]);
%         ylim(axes1,[0.5 2542.5]);
%T2_S2.........................................................................
%         xlim(axes1,[0.5 5487.5]);
%         ylim(axes1,[0.5 2163.5]);
%T2_S4.........................................................................
%        xlim(axes1,[0.5 5439.5]);
%        ylim(axes1,[0.5 2251.5]);
%T3_S3.........................................................................
%        xlim(axes1,[0.5 6004.5]);
%        ylim(axes1,[0.5 2561.5]);
%T3_S4.........................................................................
         % xlim(axes1,[0.5 6318.5]);
         % ylim(axes1,[0.5 2555.5]);
%Axolotl S4.....................................................................
         % xlim(axes1,[0.5 6940.5]);
         % ylim(axes1,[0.5 2389.5]);
%Axolotl S7.....................................................................
         % xlim(axes1,[0.5 6017.5]);
         % ylim(axes1,[0.5 2390.5]);
%Laevis S9.....................................................................
         % xlim(axes1,[0.5 4649.5]);
         % ylim(axes1,[0.5 1936.5]);
%Laevis S10.....................................................................
         % xlim(axes1,[0.5 4654.5]);
         % ylim(axes1,[0.5 2281.5]);           
%...............................................................................
         xlim(axes1,[0.5 xend]);
         ylim(axes1,[0.5 yend]);

        box(axes1,'on');
        hold(axes1,'all');
        % Create image
        image(Lrgb,'Parent',axes1,'CDataMapping','scaled');
        %image(L,'Parent',axes1,'CDataMapping','scaled');
        % Create colorbar
        colorbar('peer',axes1);
        %box on;
           % code
        %set(axes1,'XTick',[], 'YTick', [])
        % gca = ax
        %set(axes1,'xticklabel',[])
        title('Aspect Ratio (Length/Width)','FontSize', 15, 'Color', 'black', 'FontWeight', 'bold')
        set(axes1,'TickLength',[0 0],'LineWidth',2,'XTick',[],'YTick',[]);
        %set(axes1,'TickLength',[0 0],'LineWidth',2,'XTick',[],'YTick',[],'xticklabel',[],'yticklabel',[]);
        yyaxis right
        ylabel ('Aspect Ratio','FontSize', 15, 'Color', 'black', 'FontWeight', 'bold')
        k = [0, 0, 0];
        axes1.YColor = k;%
        %set(axes1,'YTick',[],'yticklabel',[]);
        set(gcf,'Position',get(0,'Screensize'))
        saveas(figure2,[pathname,'Aspect_Ratio.tif']);
 %% Plot map of cell orientation as a vector of aspect ratio magnitude
% Aspect = Aspect(1:end-5,1);
% O = O(1:end-5,1);
% centroidsX = centroidsX(1:end-5,1);
% centroidsY = centroidsY(1:end-5,1);
%..........................................................................
Coreo2 = -deg2rad(O);
u = cos(Coreo2).*Aspect;
v = sin(Coreo2).*Aspect;
%..........................................................................
% X = reshape(centroidsX,[30 45]);
% Y = reshape(centroidsY,[30 45]);
% U = reshape(u,[30 45]);% 40 134
% V = reshape(v,[30 45]);% 54 99
%%
% [xgrid,ygrid] = meshgrid(1:1:size(I6,2),1:1:size(I6,1));
% umap = false(size(I6));
% vmap = false(size(I6));
% 
% for kk=1:length(centroidsX)
%     x = round(centroidsX(kk,1));
%     y = round(centroidsY(kk,1));
%     umap(y,x) = u(kk,1);
%     vmap(y,x) = v(kk,1);
% end
%%
% figure;
% quiver(xgrid,flip(ygrid),umap,vmap)
%% ..........................................................................
figure;
quiverC2D(centroidsX,centroidsY,u,v,'scale',2,'LineWidth', 1,'MaxHeadSize', 1)
set(gcf,'Position',get(0,'Screensize'))
saveas(gcf,[pathname,'Aspect_Ratio_Orientation.tif']);
% ..........................................................................
%% Visualize Area Colormaps
%Arrangle angles into bins
%O =O(filt);
[~,~,idx] = histcounts(Area,min(Area)-1:max(Area)+1);
% Paint the pixels with corresponding bins
L1 = zeros(size(I6));
%Identifier = 1:1:length(List); %Change here based on groups...............
for ii = 1:length(Area)
    L1(Pixel(ii).PixelIdxList) = idx(ii);    %fill in indices
end
%% Colorplot Area
figure3 = figure('Colormap',...
        [0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 0.9375;0.125 1 0.875;0.1875 1 0.8125;0.25 1 0.75;0.3125 1 0.6875;0.375 1 0.625;0.4375 1 0.5625;0.5 1 0.5;0.5625 1 0.4375;0.625 1 0.375;0.6875 1 0.3125;0.75 1 0.25;0.8125 1 0.1875;0.875 1 0.125;0.9375 1 0.0625;1 1 0;1 0.899999976158142 0;1 0.800000011920929 0;1 0.699999988079071 0;1 0.600000023841858 0;1 0.5 0;1 0.400000005960464 0;1 0.300000011920929 0;1 0.200000002980232 0;1 0.100000001490116 0;1 0 0;0.964285731315613 0 0;0.928571403026581 0 0;0.892857134342194 0 0;0.857142865657806 0 0;0.821428596973419 0 0;0.785714268684387 0 0;0.75 0 0;0.714285731315613 0 0;0.678571403026581 0 0;0.642857134342194 0 0;0.607142865657806 0 0;0.571428596973419 0 0;0.535714268684387 0 0;0.5 0 0]);
%Lrgb = label2rgb(L1);
Lrgb = label2rgb(L1);
% Setting up axis
%axes1 = axes('Parent',figure1,'YDir','reverse','Layer','top','CLim',[1 5]);
axes1 = axes('Parent',figure3,'YDir','reverse','Layer','top','CLim',[min(Area)-1 max(Area)+1]);
%Lim = caxis;
%caxis([1 5])
set(axes1,'TickLength',[0 0]);
%..............................................................................
%           xlim auto;
%           ylim auto;
%T1_S4.........................................................................
%         xlim(axes1,[0.5 6311.5]);
%         ylim(axes1,[0.5 2467.5]);
%T1_S5.........................................................................
%         xlim(axes1,[0.5 6197.5]);
%         ylim(axes1,[0.5 2542.5]);
%T2_S2.........................................................................
%         xlim(axes1,[0.5 5487.5]);
%         ylim(axes1,[0.5 2163.5]);
%T2_S4.........................................................................
%        xlim(axes1,[0.5 5439.5]);
%        ylim(axes1,[0.5 2251.5]);
%T3_S3.........................................................................
%        xlim(axes1,[0.5 6004.5]);
%        ylim(axes1,[0.5 2561.5]);
%T3_S4.........................................................................
         % xlim(axes1,[0.5 6318.5]);
         % ylim(axes1,[0.5 2555.5]);
%Axolotl S4.....................................................................
         % xlim(axes1,[0.5 6940.5]);
         % ylim(axes1,[0.5 2389.5]);
%Axolotl S7.....................................................................
         % xlim(axes1,[0.5 6017.5]);
         % ylim(axes1,[0.5 2390.5]);
%Laevis S9.....................................................................
         % xlim(axes1,[0.5 4649.5]);
         % ylim(axes1,[0.5 1936.5]);
%Laevis S10.....................................................................
         % xlim(axes1,[0.5 4654.5]);
         % ylim(axes1,[0.5 2281.5]);           
%...............................................................................
         xlim(axes1,[0.5 xend]);
         ylim(axes1,[0.5 yend]);

        box(axes1,'on');
        hold(axes1,'all');
        % Create image
        image(Lrgb,'Parent',axes1,'CDataMapping','scaled');
        %image(L,'Parent',axes1,'CDataMapping','scaled');
        % Create colorbar
        colorbar('peer',axes1);
        %box on;
           % code
        %set(axes1,'XTick',[], 'YTick', [])
        % gca = ax
        %set(axes1,'xticklabel',[])
        title('MCC Area (\mum\^2)','FontSize', 15, 'Color', 'black', 'FontWeight', 'bold')
        set(axes1,'TickLength',[0 0],'LineWidth',2,'XTick',[],'YTick',[]);
        %set(axes1,'TickLength',[0 0],'LineWidth',2,'XTick',[],'YTick',[],'xticklabel',[],'yticklabel',[]);
        yyaxis right
        ylabel ('Area','FontSize', 15, 'Color', 'black', 'FontWeight', 'bold')
        k = [0, 0, 0];
        axes1.YColor = k;%
        %set(axes1,'YTick',[],'yticklabel',[]);
        set(gcf,'Position',get(0,'Screensize'))
        saveas(figure3,[pathname,'Area.tif']);
        close all;
%% Visualize Circularity Colormaps
%Arrangle angles into bins
%O =O(filt);
edges = 0:0.1:1;
[~,~,bins] = histcounts(Cir,edges);
% Paint the pixels with corresponding bins
L1 = zeros(size(I6));
%Identifier = 1:1:length(List); %Change here based on groups...............
for ii = 1:length(Aspect)
    L1(Pixel(ii).PixelIdxList) = bins(ii);    %fill in indices
end
%% Colorplot Circularity
figure4 = figure('Colormap',...
        [0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 0.9375;0.125 1 0.875;0.1875 1 0.8125;0.25 1 0.75;0.3125 1 0.6875;0.375 1 0.625;0.4375 1 0.5625;0.5 1 0.5;0.5625 1 0.4375;0.625 1 0.375;0.6875 1 0.3125;0.75 1 0.25;0.8125 1 0.1875;0.875 1 0.125;0.9375 1 0.0625;1 1 0;1 0.899999976158142 0;1 0.800000011920929 0;1 0.699999988079071 0;1 0.600000023841858 0;1 0.5 0;1 0.400000005960464 0;1 0.300000011920929 0;1 0.200000002980232 0;1 0.100000001490116 0;1 0 0;0.964285731315613 0 0;0.928571403026581 0 0;0.892857134342194 0 0;0.857142865657806 0 0;0.821428596973419 0 0;0.785714268684387 0 0;0.75 0 0;0.714285731315613 0 0;0.678571403026581 0 0;0.642857134342194 0 0;0.607142865657806 0 0;0.571428596973419 0 0;0.535714268684387 0 0;0.5 0 0]);
%Lrgb = label2rgb(L1);
Lrgb = label2rgb(L1);
% Setting up axis
%axes1 = axes('Parent',figure1,'YDir','reverse','Layer','top','CLim',[1 5]);
axes1 = axes('Parent',figure4,'YDir','reverse','Layer','top','CLim',[0 1]);
%Lim = caxis;
%caxis([1 5])
set(axes1,'TickLength',[0 0]);
%..............................................................................
%           xlim auto;
%           ylim auto;
%T1_S4.........................................................................
%         xlim(axes1,[0.5 6311.5]);
%         ylim(axes1,[0.5 2467.5]);
%T1_S5.........................................................................
%         xlim(axes1,[0.5 6197.5]);
%         ylim(axes1,[0.5 2542.5]);
%T2_S2.........................................................................
%         xlim(axes1,[0.5 5487.5]);
%         ylim(axes1,[0.5 2163.5]);
%T2_S4.........................................................................
%        xlim(axes1,[0.5 5439.5]);
%        ylim(axes1,[0.5 2251.5]);
%T3_S3.........................................................................
%        xlim(axes1,[0.5 6004.5]);
%        ylim(axes1,[0.5 2561.5]);
%T3_S4.........................................................................
         % xlim(axes1,[0.5 6318.5]);
         % ylim(axes1,[0.5 2555.5]);
%Axolotl S4.....................................................................
         % xlim(axes1,[0.5 6940.5]);
         % ylim(axes1,[0.5 2389.5]);
%Axolotl S7.....................................................................
         % xlim(axes1,[0.5 6017.5]);
         % ylim(axes1,[0.5 2390.5]);
%Laevis S9.....................................................................
         % xlim(axes1,[0.5 4649.5]);
         % ylim(axes1,[0.5 1936.5]);
%Laevis S10.....................................................................
         % xlim(axes1,[0.5 4654.5]);
         % ylim(axes1,[0.5 2281.5]);           
%...............................................................................
         xlim(axes1,[0.5 xend]);
         ylim(axes1,[0.5 yend]);

        box(axes1,'on');
        hold(axes1,'all');
        % Create image
        image(Lrgb,'Parent',axes1,'CDataMapping','scaled');
        %image(L,'Parent',axes1,'CDataMapping','scaled');
        % Create colorbar
        colorbar('peer',axes1);
        %box on;
           % code
        %set(axes1,'XTick',[], 'YTick', [])
        % gca = ax
        %set(axes1,'xticklabel',[])
        title('MCC Circularity','FontSize', 15, 'Color', 'black', 'FontWeight', 'bold')
        set(axes1,'TickLength',[0 0],'LineWidth',2,'XTick',[],'YTick',[]);
        %set(axes1,'TickLength',[0 0],'LineWidth',2,'XTick',[],'YTick',[],'xticklabel',[],'yticklabel',[]);
        yyaxis right
        ylabel ('Circularity','FontSize', 15, 'Color', 'black', 'FontWeight', 'bold')
        k = [0, 0, 0];
        axes1.YColor = k;%
        %set(axes1,'YTick',[],'yticklabel',[]);
        set(gcf,'Position',get(0,'Screensize'))
        saveas(figure4,[pathname,'Circularity.tif']);
        close all;
%% Colormaps Test
% x = randi([1 5],[5 3]);
% [xx, yy] = meshgrid(1:3,1:5);
% figure; surface(xx,yy,x);set(gca,'YDir','reverse');C = colormap(turbo(5)); colorbar
% figure; surface(xx,yy,x);set(gca,'YDir','reverse');C = colormap(summer(5)); colorbar
% figure; surface(xx,yy,x);set(gca,'YDir','reverse');C = colormap(jet(5)); colorbar
% figure; surface(xx,yy,x);C = colormap(winter(5)); colorbar
end