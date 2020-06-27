classdef unitTestInsidePanel < matlab.unittest.TestCase
    methods (Test)
        function testInsidePanel(testCase) % T1.1
            % State: No InsidePanel yet
            % Input: New InsidePanel
            % Expected Output: Initial value of panel
            current_floor = 1;
            direction = "Stationary";
            door_state = "Closed";
            route = [0, 0, 0];      % Corresponds to each of the three floors, 1 for checked
            pre_direction = "Up";   % Give a direction so that the elevator can proceed
            move_time = 2;          % Set time for moving
            door_time = 2;          % Set time for auto door_open
            % Execute the function
            IP = InsidePanel;
            % Check expected output
            testCase.verifyEqual(current_floor,IP.current_floor);
            testCase.verifyEqual(direction,IP.direction);
            testCase.verifyEqual(door_state,IP.door_state);
            testCase.verifyEqual(route,IP.route);
            testCase.verifyEqual(pre_direction,IP.pre_direction);
            testCase.verifyEqual(move_time,IP.move_time);
            testCase.verifyEqual(door_time,IP.door_time);    
        end
        
        function testgetCurrentFloor(testCase)
            IP = InsidePanel;
            current_floor = 1;
            
            IP.getCurrentFloor();
            
            testCase.verifyEqual(current_floor,IP.current_floor);
        end
        
        function testgetPreDirection(testCase)
            IP = InsidePanel;
            pre_direction = "Up";
            
            IP.getPreDirection();
            
            testCase.verifyEqual(pre_direction,IP.pre_direction);
        end
        
        function testgetDirection(testCase)
            IP = InsidePanel;
            direction = "Stationary";
            
            IP.getDirection();
            
            testCase.verifyEqual(direction,IP.direction);
        end
        
        function testgetDoorState(testCase)
            IP = InsidePanel;
            door_state = "Closed";
            
            IP.getDoorState();
            
            testCase.verifyEqual(door_state,IP.door_state);
        end
        
        function testopenDoor(testCase)
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

            door_state = "Opened";
            
            ele1.openDoor();
            
            testCase.verifyEqual(door_state,ele1.door_state);
            close(ele1_app.UIFigure);
            close(ele2_app.UIFigure);
            close(ele1_mod.UIFigure);
            close(ele2_mod.UIFigure);
            close(flr1_app.UIFigure);
            close(flr2_app.UIFigure);
            close(flr3_app.UIFigure);
        end
        
        function testcloseDoor(testCase)
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

            door_state = "Closed";
            
            ele1.closeDoor();
            
            testCase.verifyEqual(door_state,ele1.door_state);
            close(ele1_app.UIFigure);
            close(ele2_app.UIFigure);
            close(ele1_mod.UIFigure);
            close(ele2_mod.UIFigure);
            close(flr1_app.UIFigure);
            close(flr2_app.UIFigure);
            close(flr3_app.UIFigure);

        end
        
        function testupdateDisp(testCase)
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

            ele1.direction = "Stationary";
            ele1.current_floor = 1;
            
            CurrentFloorValue = mat2str(ele1.current_floor);
            DirectionValue = ele1.direction;
            DoorStateValue = ele1.door_state;
            Floor1CheckValue = false;
            Floor1CheckEnable = 'off';
            Floor2CheckEnable = 'on';
            Floor3CheckEnable = 'on';
            LayoutRow = 3;  
            
            ele1.updateDisp();
            
            testCase.verifyEqual(cellstr(CurrentFloorValue),ele1.app.CurrentFloor.Value);
            testCase.verifyEqual(cellstr(DirectionValue),ele1.app.Direction.Value);
            testCase.verifyEqual(cellstr(DoorStateValue),ele1.app.DoorState.Value);
            testCase.verifyEqual(Floor1CheckValue,ele1.app.Floor1Check.Value);
            testCase.verifyEqual(Floor1CheckEnable,ele1.app.Floor1Check.Enable);
            testCase.verifyEqual(Floor2CheckEnable,ele1.app.Floor2Check.Enable);
            testCase.verifyEqual(Floor3CheckEnable,ele1.app.Floor3Check.Enable);
            testCase.verifyEqual(LayoutRow,ele1.model.Image.Layout.Row);
            
            
            ele1.direction = "Stationary";
            ele1.current_floor = 2;
            
            CurrentFloorValue = mat2str(ele1.current_floor);
            DirectionValue = ele1.direction;
            DoorStateValue = ele1.door_state;
            Floor2CheckValue = false;
            Floor1CheckEnable = 'on';
            Floor2CheckEnable = 'off';
            Floor3CheckEnable = 'on';
            LayoutRow = 2;  
            
            ele1.updateDisp();
            
            testCase.verifyEqual(cellstr(CurrentFloorValue),ele1.app.CurrentFloor.Value);
            testCase.verifyEqual(cellstr(DirectionValue),ele1.app.Direction.Value);
            testCase.verifyEqual(cellstr(DoorStateValue),ele1.app.DoorState.Value);
            testCase.verifyEqual(Floor2CheckValue,ele1.app.Floor2Check.Value);
            testCase.verifyEqual(Floor1CheckEnable,ele1.app.Floor1Check.Enable);
            testCase.verifyEqual(Floor2CheckEnable,ele1.app.Floor2Check.Enable);
            testCase.verifyEqual(Floor3CheckEnable,ele1.app.Floor3Check.Enable);
            testCase.verifyEqual(LayoutRow,ele1.model.Image.Layout.Row);
            
            
            ele1.direction = "Stationary";
            ele1.current_floor = 3;
            
            CurrentFloorValue = mat2str(ele1.current_floor);
            DirectionValue = ele1.direction;
            DoorStateValue = ele1.door_state;
            Floor3CheckValue = false;
            Floor1CheckEnable = 'on';
            Floor2CheckEnable = 'on';
            Floor3CheckEnable = 'off';
            LayoutRow = 1;  
            
            ele1.updateDisp();
            
            testCase.verifyEqual(cellstr(CurrentFloorValue),ele1.app.CurrentFloor.Value);
            testCase.verifyEqual(cellstr(DirectionValue),ele1.app.Direction.Value);
            testCase.verifyEqual(cellstr(DoorStateValue),ele1.app.DoorState.Value);
            testCase.verifyEqual(Floor3CheckValue,ele1.app.Floor3Check.Value);
            testCase.verifyEqual(Floor1CheckEnable,ele1.app.Floor1Check.Enable);
            testCase.verifyEqual(Floor2CheckEnable,ele1.app.Floor2Check.Enable);
            testCase.verifyEqual(Floor3CheckEnable,ele1.app.Floor3Check.Enable);
            testCase.verifyEqual(LayoutRow,ele1.model.Image.Layout.Row);
            
            ele1.direction = "Up";
            ele1.current_floor = 3;
            
            CurrentFloorValue = mat2str(ele1.current_floor);
            DirectionValue = ele1.direction;
            DoorStateValue = ele1.door_state;
           
            Floor1CheckEnable = 'on';
            Floor2CheckEnable = 'on';
            Floor3CheckEnable = 'off';
            LayoutRow = 1;  
            
            ele1.updateDisp();
            
            testCase.verifyEqual(cellstr(CurrentFloorValue),ele1.app.CurrentFloor.Value);
            testCase.verifyEqual(cellstr(DirectionValue),ele1.app.Direction.Value);
            testCase.verifyEqual(cellstr(DoorStateValue),ele1.app.DoorState.Value);
            
            testCase.verifyEqual(Floor1CheckEnable,ele1.app.Floor1Check.Enable);
            testCase.verifyEqual(Floor2CheckEnable,ele1.app.Floor2Check.Enable);
            testCase.verifyEqual(Floor3CheckEnable,ele1.app.Floor3Check.Enable);
            testCase.verifyEqual(LayoutRow,ele1.model.Image.Layout.Row);
            
            close(ele1_app.UIFigure);
            close(ele2_app.UIFigure);
            close(ele1_mod.UIFigure);
            close(ele2_mod.UIFigure);
            close(flr1_app.UIFigure);
            close(flr2_app.UIFigure);
            close(flr3_app.UIFigure);

        end
        
        function testaddDesFloor(testCase)
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
            
            ele1.current_floor = 2;
            ele1.pre_direction = "Up";
            
            ele1.addDesFloor(1);
            
            testCase.verifyEqual(ele1.route(1),1);
            
            close(ele1_app.UIFigure);
            close(ele2_app.UIFigure);
            close(ele1_mod.UIFigure);
            close(ele2_mod.UIFigure);
            close(flr1_app.UIFigure);
            close(flr2_app.UIFigure);
            close(flr3_app.UIFigure);
        end
        
        function testdelDesFloor(testCase)
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
            
            ele1.current_floor = 2;
            ele1.pre_direction = "Up";
            
            ele1.delDesFloor(1);
            
            testCase.verifyEqual(ele1.route(1),0);
            
            close(ele1_app.UIFigure);
            close(ele2_app.UIFigure);
            close(ele1_mod.UIFigure);
            close(ele2_mod.UIFigure);
            close(flr1_app.UIFigure);
            close(flr2_app.UIFigure);
            close(flr3_app.UIFigure);
        end
        
        function testcheckRoute(testCase)
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
            
            ele1.current_floor = 1;
            ele1.pre_direction = "Up";
            ele1.route(1) = 0;
            ele1.route(2) = 1;
            ele1.route(3) = 1;
            
            ele1.checkRoute();
            
            testCase.verifyEqual(ele1.direction,"Up");
            
            
            ele1.current_floor = 3;
            ele1.pre_direction = "Up";
            ele1.route(1) = 0;
            ele1.route(2) = 1;
            ele1.route(3) = 0;
            
            ele1.checkRoute();
            
            testCase.verifyEqual(ele1.direction,"Down");
            
            ele1.current_floor = 2;
            ele1.pre_direction = "Up";
            ele1.route(1) = 0;
            ele1.route(2) = 0;
            ele1.route(3) = 1;
            
            ele1.checkRoute();
            
            testCase.verifyEqual(ele1.direction,"Up");
            
            ele1.current_floor = 2;
            ele1.pre_direction = "Down";
            ele1.route(1) = 1;
            ele1.route(2) = 0;
            ele1.route(3) = 0;
            
            ele1.checkRoute();
            
            testCase.verifyEqual(ele1.direction,"Down");
            
            close(ele1_app.UIFigure);
            close(ele2_app.UIFigure);
            close(ele1_mod.UIFigure);
            close(ele2_mod.UIFigure);
            close(flr1_app.UIFigure);
            close(flr2_app.UIFigure);
            close(flr3_app.UIFigure);
        end
        
        function testgoUp(testCase)
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
            
          
            ele1.goUp();
            
            testCase.verifyEqual(ele1.pre_direction,"Up");
            testCase.verifyEqual(ele1.direction,"Up");
            
            close(ele1_app.UIFigure);
            close(ele2_app.UIFigure);
            close(ele1_mod.UIFigure);
            close(ele2_mod.UIFigure);
            close(flr1_app.UIFigure);
            close(flr2_app.UIFigure);
            close(flr3_app.UIFigure);
        end
        
        function testgoDown(testCase)
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
            
          
            ele1.goDown();
            
            testCase.verifyEqual(ele1.pre_direction,"Down");
            testCase.verifyEqual(ele1.direction,"Down");
            
            close(ele1_app.UIFigure);
            close(ele2_app.UIFigure);
            close(ele1_mod.UIFigure);
            close(ele2_mod.UIFigure);
            close(flr1_app.UIFigure);
            close(flr2_app.UIFigure);
            close(flr3_app.UIFigure);
        end
        
        function testarrive(testCase)
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
            
            ele1.direction = "Up";
            ele1.current_floor = 1;
            ele1.route(1) = 0;
            ele1.route(2) = 1;
            ele1.route(3) = 1;
          
            ele1.arrive();
            
            testCase.verifyEqual(ele1.current_floor,2);
            testCase.verifyEqual(ele1.direction,"Stationary");
            
            ele1.direction = "Up";
            ele1.current_floor = 1;
            ele1.route(1) = 1;
            ele1.route(2) = 0;
            ele1.route(3) = 1;
          
            ele1.arrive();
            
            testCase.verifyEqual(ele1.current_floor,2);
            testCase.verifyEqual(ele1.direction,"Up");
            
            ele1.direction = "Down";
            ele1.current_floor = 2;
            ele1.route(1) = 0;
            ele1.route(2) = 0;
            ele1.route(3) = 0;
          
            ele1.arrive();
            
            testCase.verifyEqual(ele1.current_floor,1);
            testCase.verifyEqual(ele1.direction,"Stationary");
           
            
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