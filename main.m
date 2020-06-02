close all;

% Classes
ele1 = Elevator1;
ele2 = Elevator2;
flr1 = Floor1;
flr2 = Floor2;
flr3 = Floor3;
controller = ControlUnit;

% Apps
ele1_app = elevator1;
ele2_app = elevator2;
flr1_app = floor1;
flr2_app = floor2;
flr3_app = floor3;

% Setups for controller
controller.ele1 = ele1;
controller.ele2 = ele2;
controller.floor1 = flr1;
controller.floor2 = flr2;
controller.floor3 = flr3;

% Setups for ele1
ele1.app = ele1_app;
ele1.controller = controller;
% Setups for ele1_app
ele1_app.inside_panel = ele1;

% Setups for ele2
ele2.app = ele2_app;
ele2.controller = controller;
% Setups for ele2_app
ele2_app.inside_panel = ele2;

% Setups for flr1
flr1.app = flr1_app;
flr1.controller = controller;
% Setups for flr1_app
flr1_app.outside_panel = flr1;

% Setups for flr2
flr2.app = flr2_app;
flr2.controller = controller;
% Setups for flr2_app
flr2_app.outside_panel = flr2;

% Setups for flr3
flr3.app = flr3_app;
flr3.controller = controller;
% Setups for flr3_app
flr3_app.outside_panel = flr3;
