classdef unitTestControlUnit < matlab.unittest.TestCase
    methods (Test)
        function testgetEleFloor(testCase) 
            ele1 = Elevator1;
            ele2 = Elevator2;
            flr1 = Floor1;
            flr2 = Floor2;
            flr3 = Floor3;
            controller = ControlUnit;

            % Apps
            ele1_app = elevator1;
            ele2_app = elevator2;
            ele1_mod = ele1_model;
            ele2_mod = ele2_model;
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
            ele1.model = ele1_mod;

            % Setups for ele2
            ele2.app = ele2_app;
            ele2.controller = controller;
            % Setups for ele2_app
            ele2_app.inside_panel = ele2;
            ele2.model = ele2_mod;

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
            
            ele_num = 1;
            flr = controller.ele1.getCurrentFloor();
            
            floor=controller.getEleFloor(ele_num);
            
            testCase.verifyEqual(floor,flr);
            
            ele_num = 2;
            flr = controller.ele2.getCurrentFloor();
            
            floor=controller.getEleFloor(ele_num);
            
            testCase.verifyEqual(floor,flr);
            
            close(ele1_app.UIFigure);
            close(ele2_app.UIFigure);
            close(ele1_mod.UIFigure);
            close(ele2_mod.UIFigure);
            close(flr1_app.UIFigure);
            close(flr2_app.UIFigure);
            close(flr3_app.UIFigure);
        end
        
        function testdispatchEle(testCase) 
            ele1 = Elevator1;
            ele2 = Elevator2;
            flr1 = Floor1;
            flr2 = Floor2;
            flr3 = Floor3;
            controller = ControlUnit;

            % Apps
            ele1_app = elevator1;
            ele2_app = elevator2;
            ele1_mod = ele1_model;
            ele2_mod = ele2_model;
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
            ele1.model = ele1_mod;

            % Setups for ele2
            ele2.app = ele2_app;
            ele2.controller = controller;
            % Setups for ele2_app
            ele2_app.inside_panel = ele2;
            ele2.model = ele2_mod;

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
            
            floor = 2;
            controller.ele1.current_floor = 2;
            controller.ele1.direction = "Stationary";
            direction = "Up";
            
            
            controller.dispatchEle(floor, direction);
            
            testCase.verifyEqual(controller.ele1.route(2),0);
            
            floor = 2;
            controller.ele2.current_floor = 2;
            controller.ele2.direction = "Stationary";
            direction = "Up";
            
            
            controller.dispatchEle(floor, direction);
            
            testCase.verifyEqual(controller.ele2.route(2),0);
            
            floor = 3;
            controller.ele1.current_floor = 2;
            controller.ele2.current_floor = 1;
            controller.ele1.route(floor) = 0;
            controller.ele2.route(floor) = 0;
            controller.ele1.pre_direction = "Up";
           
            direction = "Up";
            
            
            controller.dispatchEle(floor, direction);
            
            testCase.verifyEqual(controller.ele1.route(3),1);
            
            floor = 2;
            controller.ele1.current_floor = 3;
            controller.ele2.current_floor = 1;
            controller.ele1.route(floor) = 0;
            controller.ele2.route(floor) = 0;
            controller.ele2.pre_direction = "Up";
            
            direction = "Up";
            
            
            controller.dispatchEle(floor, direction);
            
            testCase.verifyEqual(controller.ele2.route(2),1);
            
            floor = 2;
            controller.ele1.current_floor = 3;
            controller.ele2.current_floor = 1;
            controller.ele1.route(floor) = 0;
            controller.ele2.route(floor) = 0;
            controller.ele1.pre_direction = "Down";
            controller.ele2.pre_direction = "Down";
            
            direction = "Up";
            
            
            controller.dispatchEle(floor, direction);
            
            testCase.verifyEqual(controller.ele1.route(2),1);
            
            floor = 2;
            controller.ele1.current_floor = 1;
            controller.ele2.current_floor = 3;
            controller.ele1.route(floor) = 0;
            controller.ele2.route(floor) = 0;
            controller.ele1.pre_direction = "Down";
            controller.ele2.pre_direction = "Down";
            
            direction = "Up";
            
            
            controller.dispatchEle(floor, direction);
            
            testCase.verifyEqual(controller.ele2.route(2),1);
            
            floor = 1;
            controller.ele1.current_floor = 2;
            controller.ele2.current_floor = 3;
            controller.ele1.route(floor) = 0;
            controller.ele2.route(floor) = 0;
            controller.ele1.pre_direction = "Stationary";
            controller.ele2.pre_direction = "Stationary";
            
            direction = "Up";
            
            
            controller.dispatchEle(floor, direction);
            
            testCase.verifyEqual(controller.ele1.route(1),1);
            
            floor = 1;
            controller.ele1.current_floor = 3;
            controller.ele2.current_floor = 3;
            controller.ele1.route(floor) = 0;
            controller.ele2.route(floor) = 0;
            controller.ele1.pre_direction = "Stationary";
            controller.ele2.pre_direction = "Stationary";
            
            direction = "Up";
            
            
            controller.dispatchEle(floor, direction);
            
            testCase.verifyEqual(controller.ele1.route(1),1);
            
            
            close(ele1_app.UIFigure);
            close(ele2_app.UIFigure);
            close(ele1_mod.UIFigure);
            close(ele2_mod.UIFigure);
            close(flr1_app.UIFigure);
            close(flr2_app.UIFigure);
            close(flr3_app.UIFigure);
        end
        
        
    end
end