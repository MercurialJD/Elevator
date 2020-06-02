classdef InsidePanel < handle
    
    properties
        app
        controller
        current_floor
        direction
        door_state
        route
        pre_direction
        move_timer
        door_timer
    end
    
    methods
        function obj = InsidePanel()
            obj.current_floor = 1;
            obj.direction = "Stationary";
            obj.door_state = "Closed";
            obj.route = [0, 0, 0];
            obj.pre_direction = "Up";
            obj.move_timer = timer();
            obj.door_timer = timer();
        end
        
        function curr_flr = getCurrentFloor(obj)
            curr_flr = obj.current_floor;
        end
        
        function dire = getDirection(obj)
            dire = obj.direction;
        end
        
        function state = getDoorState(obj)
            state = obj.door_state;
        end
        
        function [] = openDoor(obj)
            obj.door_state = "Opened";
            obj.updateDisp();
        end
        
        function [] = closeDoor(obj, ~, ~)
            obj.door_state = "Closed";
            obj.updateDisp();
            
            if get(obj.door_timer, 'Running')
                stop(obj.door_timer);
            end
            
            obj.checkRoute();
        end
        
        function [] = updateDisp(obj)
            % inner
            obj.app.CurrentFloor.Value = mat2str(obj.current_floor);
            obj.app.Direction.Value = obj.direction;
            obj.app.DoorState.Value = obj.door_state;
            if obj.direction == "Stationary"
                switch obj.current_floor
                    case 1
                        obj.app.Floor1Check.Value = false;
                        obj.app.Floor1Check.Enable = false;
                    case 2
                        obj.app.Floor2Check.Value = false;
                        obj.app.Floor2Check.Enable = false;
                    case 3
                        obj.app.Floor3Check.Value = false;
                        obj.app.Floor3Check.Enable = false;
                end
            else
                switch obj.current_floor
                    case 1
                        obj.app.Floor1Check.Enable = true;
                    case 2
                        obj.app.Floor2Check.Enable = true;
                    case 3
                        obj.app.Floor3Check.Enable = true;
                end
            end
            
            % outer
            obj.controller.updateOutDisp();
        end
        
        function [] = addDesFloor(obj, floor_num)
            obj.route(floor_num) = 1;
            obj.checkRoute();
        end
        
        function [] = delDesFloor(obj, floor_num)
            obj.route(floor_num) = 0;
        end
        
        function [] = checkRoute(obj)
            if obj.route(obj.current_floor) == 1
                obj.delDesFloor(obj.current_floor);
                stop(obj.door_timer);
                obj.openDoor();
                obj.door_timer = timer('StartDelay', 1, 'TimerFcn', @obj.closeDoor);
                start(obj.door_timer);
            end
            if obj.current_floor == 1
                for i = 2:3
                    if obj.route(i) == 1
                        obj.goUp();
                        return
                    end
                end
            elseif obj.current_floor == 3
                for i = 1:2
                    if obj.route(i) == 1
                        obj.goDown();
                        return
                    end
                end
            else   % obj.current_floor == 2
                if obj.pre_direction == "Up"
                    for i = (obj.current_floor+1):3
                        if(obj.route(i) == 1)
                            obj.goUp();
                            return
                        end
                    end
                elseif obj.pre_direction == "Down"
                    for i = 1:(obj.current_floor-1)
                        if(obj.route(i) == 1)
                            obj.goDown();
                            return
                        end
                    end
                end
            end
            
            for i = 1:3
                if obj.route(i) == 1
                    if i > obj.current_floor
                        obj.goUp();
                        return
                    elseif i < obj.current_floor
                        obj.goDown();
                        return
                    end
                end
            end
        end
        
        function goUp(obj)
            if(obj.getDoorState) ~= "Closed"
                return;
            end
            obj.pre_direction = "Up";
            obj.direction = "Up";
            disp("GOUP!");
            obj.updateDisp();
            obj.move_timer = timer('StartDelay', 2, 'TimerFcn', @obj.arrive);
            start(obj.move_timer);
        end
        
        function goDown(obj)
            if(obj.getDoorState) ~= "Closed"
                return;
            end
            obj.pre_direction = "Down";
            obj.direction = "Down";
            disp("GODOWN!");
            obj.updateDisp();
            obj.move_timer = timer('StartDelay', 2, 'TimerFcn', @obj.arrive);
            start(obj.move_timer);
        end
        
        function [] = arrive(obj, ~, ~)
            if obj.direction == "Up"
                obj.current_floor = obj.current_floor + 1;
                obj.updateDisp();
            elseif obj.direction == "Down"
                obj.current_floor = obj.current_floor - 1;
                obj.updateDisp();
            end
            
            haveChoice = false;
            for i = 1:3
                if(obj.route(i) == 1)
                    haveChoice = true;
                end
            end
            if(haveChoice == false)
                obj.direction = "Stationary";
                obj.updateDisp();
                obj.checkRoute();
                return;
            end
            
            if obj.route(obj.current_floor) == 1
                obj.route(obj.current_floor) = 0;
                stop(obj.move_timer);
                obj.direction = "Stationary";
                obj.openDoor();
                obj.door_timer = timer('StartDelay', 1, 'TimerFcn', @obj.closeDoor);
                start(obj.door_timer);
            else
                obj.checkRoute();
            end
        end
        
    end
end

