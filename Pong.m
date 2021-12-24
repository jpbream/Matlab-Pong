addpath .\

pbaspect([1 1 1]);

player = Player("Joey", Paddle(0.05, 0.4, 0.05, 0.2));
bot = Player("Computer", Paddle(0.9, 0.4, 0.05, 0.2));
ball = Ball(0.5, 0.5, 0.03);
ball.Velocity = [0.01, (rand(1, 1) * 2 - 1) / 100];

board = rectangle("Position", [0, 0, 1, 1]);

playerScore = text(0.01, 0.97, "");
botScore = text(0.75, 0.97, "");

playerPaddle = rectangle();
playerPaddle.FaceColor = [0, 0, 0];

botPaddle = rectangle();
botPaddle.FaceColor = [0, 0, 0];

circle = rectangle("Curvature", [1, 1]);
circle.FaceColor = [0, 0, 0];

set(gcf,'WindowButtonMotionFcn', @mouseMoveListener);

while (player.Score < 3 && bot.Score < 3)

    diff = ball.Position(2) - ...
        (bot.Paddle.Position(2) + bot.Paddle.Size(2) / 2);
    target = bot.Paddle.Position(2) + diff / 10;
    target = min(target, 0.97 - bot.Paddle.Size(2));
    bot.Paddle.Position(2) = max(target, 0.03);
    
    mouse = get(gcf, 'CurrentPoint');
    target = mouse(2) / 400 - player.Paddle.Size(2) / 2;
    target = min(target, 0.97 - player.Paddle.Size(2));
    player.Paddle.Position(2) = max(target, 0.03);

    ball = ball.Move();
    ball = ball.Reflect(player.Paddle.IntersectBall(ball));
    ball = ball.Reflect(bot.Paddle.IntersectBall(ball));

    if (ball.Position(1) < player.Paddle.Position(1) ...
            + player.Paddle.Size(1))
        bot.Score = bot.Score + 1;
        ball.Position = [0.5, 0.5];
        player.Paddle.Position = [0.05, 0.4];
        bot.Paddle.Position = [0.9, 0.4];
        ball.Velocity = [0.01, (rand(1, 1) * 2 - 1) / 100];
        pause(0.5);
    end

    if (ball.Position(1) > bot.Paddle.Position(1))
        % repeated code, very bad!
        player.Score = player.Score + 1;
        ball.Position = [0.5, 0.5];
        player.Paddle.Position = [0.05, 0.4];
        bot.Paddle.Position = [0.9, 0.4];
        ball.Velocity = [0.01, (rand(1, 1) * 2 - 1) / 100];
        pause(0.5);
    end

    playerScore.String = player.Name + ": " + player.Score;
    botScore.String = bot.Name + ": " + bot.Score;

    playerPaddle.Position = [player.Paddle.Position, player.Paddle.Size];
    botPaddle.Position = [bot.Paddle.Position, bot.Paddle.Size];
    circle.Position = [ball.Position - ball.Radius, 2 * ball.Radius, ...
        2 * ball.Radius];

    pause(0.01);
end

function mouseMoveListener(~, ~)
    % empty
end
