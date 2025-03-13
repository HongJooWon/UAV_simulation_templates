function helperShowLocations(deviceLoc, nodeLoc)
%HELPERSHOWLOCATIONS Visualize device and node positions in a 2D plane

%   Copyright 2021-2024 The MathWorks, Inc. 
rng('default')
clear helperFindFirstHRPPreamble;

f = figure;
ax = gca(f);

% Device
plot(ax, deviceLoc(1), deviceLoc(2), 'p','LineWidth', 1.5, 'MarkerSize', 10);

hold(ax, 'on')

% Nodes
plot(ax, nodeLoc(:, 1), nodeLoc(:, 2), 'd' ,'LineWidth',1.5,'MarkerSize', 10);
text(ax, nodeLoc(1, 1)+1.5, nodeLoc(1, 2)-1, 'A', 'FontSize', 10);
text(ax, nodeLoc(2, 1)+1.5, nodeLoc(2, 2)-1, 'B', 'FontSize', 10);
text(ax, nodeLoc(3, 1)+1.5, nodeLoc(3, 2)-1, 'C', 'FontSize', 10);
text(ax, nodeLoc(4, 1)+1.5, nodeLoc(4, 2)-1, 'D', 'FontSize', 10);

axis(ax, [0 100 0 100])

grid on;
xlabel('x-axis (meters)'),ylabel('y-axis (meters)');
legend('Device', 'Synchronized Nodes', 'Location', 'NorthWest')