%script that plots all relevant values 
%loads variables from DEM
load('DEM_store.mat');

figure('Name',['Experiment ' num2str(channel) ':'], 'NumberTitle', 'off');
subplot(3,1,1) % first subplot
plot(DEM.U(1,:), 'Color',[0.9,0.1,0.2]) % plot the data in x1 and y1
title('Prior Beliefs') % add a title to the subplot
ylabel({'Precision of';'Prior Beliefs'}) % label y axis
xlabel('Time') % label x axis
xlim([0, 64]) % Sets the x-axis limits to 0 and 60
ylim([-0.5, 2]) % Sets the y-axis limits to -1 and 4

subplot(3,1,2) % create the second subplot
plot(full(DEM.pU.v{1,1}(1,:)), 'Color','k') % plot the data in x2 and y2
%hold on
%plot(full(DEM.qU.w{1,1}(2,:)), 'Color',[0,0,0])
title('Predictions') % add a title to the subplot
ylabel({'Magnitude of';'Prediction'}) % label y axis
xlabel('Time') % label x axis
xlim([0, 64]) % Sets the x-axis limits to 0 and 60
ylim([-1, 4]) % Sets the y-axis limits to -1 and 4

subplot(3,1,3) % create the second subplot
plot(full(DEM.qU.x{1,1}(1,:)),'--', 'Color',[0,0,0]) % plot the data in x2 and y2
hold on
plot(full(DEM.qU.x{1,1}(2,:)), 'Color',[0,0.7,0.9])
title('Hidden States') % add a title to the subplot
ylabel({'Magnitude of';'Hidden States'}) % label y axis
xlabel('Time') % label x axis
xlim([0, 64]) % Sets the x-axis limits to 0 and 60
ylim([-1, 4]) % Sets the y-axis limits to -1 and 4




