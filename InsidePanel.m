classdef InsidePanel < handle
    
    properties
        app
        controller
        current_floor
        direction
        pre_direction
        door_state
        route
        move_time
        door_time
        move_timer
        door_timer
        model
    end
    
    methods
        function obj = InsidePanel()
            % Initialization
            obj.current_floor = 1;
            obj.direction = "Stationary";
            obj.door_state = "Closed";
            obj.route = [0, 0, 0];      % Corresponds to each of the three floors, 1 for checked
            obj.pre_direction = "Up";   % Give a direction so that the elevator can proceed
            obj.move_timer = timer();   % Timer for the whole ele to move
            obj.door_timer = timer();   % Timer for the door
            obj.move_time = 2;          % Set time for moving
            obj.door_time = 2;          % Set time for auto door_open
        end
        
        function curr_flr = getCurrentFloor(obj)
            curr_flr = obj.current_floor;
        end
        
        function dire = getPreDirection(obj)
            dire = obj.pre_direction;
        end
        
        function dire = getDirection(obj)
            dire = obj.direction;
        end
        
        function state = getDoorState(obj)
            state = obj.door_state;
        end
        
        function [] = openDoor(obj)
            obj.door_state = "Opened";
            
            if get(obj.door_timer, 'Running')   % In case the "open door" button is checked, 
                                                % the timer should stop to keep the door open
                stop(obj.door_timer);
            end
            
            obj.updateDisp();
        end
        
        function [] = closeDoor(obj, ~, ~)
            obj.door_state = "Closed";
            obj.updateDisp();
            
            if get(obj.door_timer, 'Running')   % Stop the timer and proceed
                stop(obj.door_timer);
            end
            
            obj.checkRoute();
        end
        
        function [] = updateDisp(obj)
            % Inner app disp update
            obj.app.CurrentFloor.Value = mat2str(obj.current_floor);
            obj.app.Direction.Value = obj.direction;
            obj.app.DoorState.Value = obj.door_state;
            
            % Should not check current floor, meaningless
            if obj.direction == "Stationary"
                switch obj.current_floor
                    case 1
                        obj.app.Floor1Check.Value = false;
                    case 2
                        obj.app.Floor2Check.Value = false;
                    case 3
                        obj.app.Floor3Check.Value = false;
                end
            end
            
            % Enable corresponding checkbox
            switch obj.current_floor
                case 1
                    obj.app.Floor1Check.Enable = false;
                    obj.app.Floor2Check.Enable = true;
                    obj.app.Floor3Check.Enable = true;
                case 2
                    obj.app.Floor1Check.Enable = true;
                    obj.app.Floor2Check.Enable = false;
                    obj.app.Floor3Check.Enable = true;
                case 3
                    obj.app.Floor1Check.Enable = true;
                    obj.app.Floor2Check.Enable = true;
                    obj.app.Floor3Check.Enable = false;
            end
            
            % Model disp update
            switch obj.current_floor
                case 1
                    obj.model.Image.Layout.Row = 3;     % Upside down
                    if obj.door_state == "Closed"
                        obj.model.Image.ImageSource = 'ele_closed.jpg';
                    else
                        obj.model.Image.ImageSource = 'ele_opened.jpg';
                    end
                case 2
                    obj.model.Image.Layout.Row = 2;     % Upside down
                    if obj.door_state == "Closed"
                        obj.model.Image.ImageSource = 'ele_closed.jpg';
                    else
                        obj.model.Image.ImageSource = 'ele_opened.jpg';
                    end
                case 3
                    obj.model.Image.Layout.Row = 1;     % Upside down
                    if obj.door_state == "Closed"
                        obj.model.Image.ImageSource = 'ele_closed.jpg';
                    else
                        obj.model.Image.ImageSource = 'ele_opened.jpg';
                    end
            end
            
            % Outer app update
            obj.controller.updateOutDisp();
        end
        
        function [] = addDesFloor(obj, floor_num)
            obj.route(floor_num) = 1;
            obj.checkRoute();
        end
        
        function [] = delDesFloor(obj, floor_num)
            obj.route(floor_num) = 0;
            obj.checkRoute();
        end
        
        function [] = checkRoute(obj)
            % If the outside panel of this floor is checked
            if obj.route(obj.current_floor) == 1
                obj.delDesFloor(obj.current_floor);
                stop(obj.door_timer);
                obj.openDoor();
                obj.door_timer = timer('StartDelay', obj.door_time, 'TimerFcn', @obj.closeDoor);
                start(obj.door_timer);
            end
            
            if obj.current_floor == 1       % If currently located on the first floor,
                                            % just check higher two floors
                for i = 2:3
                    if obj.route(i) == 1
                        obj.goUp();
                        return
                    end
                end
            elseif obj.current_floor == 3   % If currently located on the highest floor,
                                            % just check lower two floors
                for i = 1:2
                    if obj.route(i) == 1
                        obj.goDown();
                        return
                    end
                end
            else                            % obj.current_floor == 2
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
            
            % Naive search
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
            % NEVER move when door is opened
            if(obj.getDoorState) ~= "Closed"
                return;
            end
            
            % Shut the door when moving
            obj.app.OpenDoor.Enable = false;
            
            % Set app display
            obj.pre_direction = "Up";
            obj.direction = "Up";
            disp("GOUP!");
            obj.updateDisp();
            
            % Renew move timer
            stop(obj.move_timer);
            obj.move_timer = timer('StartDelay', obj.move_time, 'TimerFcn', @obj.arrive);
            start(obj.move_timer);
        end
        
        function goDown(obj)
            % NEVER move when door is opened
            if(obj.getDoorState) ~= "Closed"
                return;
            end
            
            % Shut the door when moving
            obj.app.OpenDoor.Enable = false;
            
            % Set app display
            obj.pre_direction = "Down";
            obj.direction = "Down";
            disp("GODOWN!");
            obj.updateDisp();
            
            % Renew move timer
            stop(obj.move_timer);
            obj.move_timer = timer('StartDelay', obj.move_time, 'TimerFcn', @obj.arrive);
            start(obj.move_timer);
        end
        
        function [] = arrive(obj, ~, ~)
            stop(obj.move_timer);
            
            % Update the current_floor according to the direction
            if obj.direction == "Up"
                obj.current_floor = obj.current_floor + 1;
                obj.updateDisp();
            elseif obj.direction == "Down"
                obj.current_floor = obj.current_floor - 1;
                obj.updateDisp();
            end
            
            % If one floor is unchecked during moving and other floors
            % is not checked, then stop the ele on next floor
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

            % If current_floor is checked, stop; Ohterwise, move
            if obj.route(obj.current_floor) == 1
                % Enable open door if stationary
                obj.app.OpenDoor.Enable = true;
                
                % Clear current floor from the route
                obj.route(obj.current_floor) = 0;
                obj.direction = "Stationary";
                obj.openDoor();
                
                % Renew door timer
                stop(obj.door_timer);
                obj.door_timer = timer('StartDelay', obj.door_time, 'TimerFcn', @obj.closeDoor);
                start(obj.door_timer);
            else
                obj.checkRoute();
            end
        end
        
    end
end

