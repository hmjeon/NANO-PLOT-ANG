% Read data
data_csv = csvread('./data/Total_Angles_590.csv');

%prob = 'dx_tri';
%prob = '6HB_tri';
%prob = 'dx_hexa';
prob = '6HB_hexa';

y_max = 180;    
if strcmp(prob, 'dx_tri')
    % data_csv(:,1) - DX Tri, min 35.74, max 114.34  -> 50
    data  = data_csv(:,1);
    color = [205,0,205];
    x_min = 60 - 50;
    x_max = 60 + 50;

    %result = data > 90.0
    %data(result) = data(result) - 20
elseif strcmp(prob, '6HB_tri')
    % data_csv(:,3) - 6HB Tri
    data  = data_csv(:,2);
    color = [50,50,205];
    x_min = 60 - 50;
    x_max = 60 + 50;
elseif strcmp(prob, 'dx_hexa')
    % data_csv(:,2) - DX Hexa, min 65.78, max 161.05 -> 50
    data  = data_csv(:,3);
    color = [205,0,205];
    x_min = 120 - 50;
    x_max = 120 + 50;
    
    %result = data < 85.0
    %data(result) = data(result)
elseif strcmp(prob, '6HB_hexa')
    % data_csv(:,4) - 6HB Hexa
    data  = data_csv(:,4);
    color = [50,50,205];
    x_min = 120 - 50;
    x_max = 120 + 50;
end

%%
% Figure defaults
width  = 5;     % Width in inches
height = 4;     % Height in inches
alw    = 0.75;  % AxesLineWidth
fsz    = 12;    % Fontsize
lw     = 2.00;  % LineWidth
msz    = 8;     % MarkerSize
c      = get(0, 'DefaultAxesColorOrder');
%c      = distinguishable_colors(6);

% Set sub figure
fig = figure('units', 'inches');
ha  = tight_subplot(1, 1, [.015 .015], [.155 .035], [.155 .105]);
axes(ha(1));
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width height]);
h = histogram(data, 40, 'BinLimits', [x_min x_max], 'FaceColor', color./255, 'EdgeColor', 'w');
hold on

% Set axis and label
set(gca,'FontSize', fsz, 'LineWidth', alw);
set(gca,'XTick',(x_min:25:x_max));
get(gca,'XTick');
set(gca,'XTickLabel', num2str(get(gca, 'XTick')'));
set(gca,'YTick', (0:40:y_max));
axis([x_min x_max  0 y_max]);

yl = ylabel(['Frequency']);
xl = xlabel(['Angle distribution (deg)']);

% Normal distribution
pd     = fitdist(data, 'Normal')
mcount = max(h.Values);
mult   = sqrt(2*pi()*pd.sigma^2)*mcount;
x_val  = x_min:0.01:x_max;
y      = pdf(pd, x_val);
%plot(x_val, mult*y, 'k--');
plot(x_val, mult*y, 'LineWidth',1);
