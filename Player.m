classdef Player
    properties
        Name
        Score
        Paddle
    end

    methods
        function obj = Player(name, paddle)
            obj.Name = name;
            obj.Score = 0;
            obj.Paddle = paddle;
        end
    end
end