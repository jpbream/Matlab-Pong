classdef Ball
    properties
        Position
        Radius
        Velocity
    end

    methods
        function obj = Ball(x, y, r)
            obj.Position = [x, y];
            obj.Radius = r;
            obj.Velocity = [0, 0];
        end

        function obj = Move(obj)
            obj.Position = obj.Position + obj.Velocity;
            obj.Position(1) = min(obj.Position(1), 0.97);
            obj.Position(1) = max(obj.Position(1), 0.03);
            obj.Position(2) = min(obj.Position(2), 0.97);
            obj.Position(2) = max(obj.Position(2), 0.03);

            if (obj.Position(1) == 0.97 || obj.Position(1) == 0.03)
                obj = obj.Reflect(1);
            end

            if (obj.Position(2) == 0.97 || obj.Position(2) == 0.03)
                obj = obj.Reflect(-1);
            end
        end

        % direction = 1 for x, direction = -1 for y
        function obj = Reflect(obj, direction)
            if (direction == 1)
                obj.Velocity = [-obj.Velocity(1), obj.Velocity(2) ...
                    + (rand(1, 1) * 2 - 1) / 400];
            elseif (direction == -1)
                obj.Velocity = [obj.Velocity(1), -obj.Velocity(2) ...
                    + (rand(1, 1) * 2 - 1) / 400];
            end
        end
    end
end