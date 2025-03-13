% 시나리오 생성
scene = uavScenario(UpdateRate=2, ReferenceLocation=[0 0 0]);

color.Red = [0 0 0];

% 쿼드콥터 추가 (처음 위치)
plat = uavPlatform("UAV", scene, ...
    "ReferenceFrame", "ENU", ...
    "InitialPosition", [2 2 1]);  % 초기 위치 (예시)

updateMesh(plat,"quadrotor",{0.5},color.Red,[0 0 0],eul2quat([0 0 pi]))

% (메쉬 추가 안함! 벽/바닥 없음)

% --- 시나리오 시각화 (기본 드론 위치만 표시) ---
figure;
show3D(scene);
hold on;

% 앵커 위치 정의
anchors = [
    0 0 0;   % Anchor 1
    4 0 0;   % Anchor 2
    0 0 2;   % Anchor 3
    3 3 1    % Anchor 4
];

% 앵커 표시 (붉은 원 + 라벨)
for i = 1:size(anchors,1)
    plot3(anchors(i,1), anchors(i,2), anchors(i,3), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
    text(anchors(i,1), anchors(i,2), anchors(i,3) + 0.1, sprintf('Anchor %d', i), 'FontSize', 10);
end

% 축 설정 (원하는 공간 범위)
xlim([0 4]);
ylim([0 4]);
zlim([0 3]);

xlabel('X [m]');
ylabel('Y [m]');
zlabel('Z [m]');
title('Drone and Anchors in Empty Space');
grid on;
view(35, 20); % 보기 각도

hold off;