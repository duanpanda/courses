/*global Car, TO_RADIANS, drawRotatedImage */

var canvas   = document.getElementById('myCanvas');
var context  = canvas.getContext('2d');
var ctxW     = canvas.width;
var ctxH     = canvas.height;
var player   = new Car();
var trackHit = new Image();
var elPX     = document.getElementById('px');
var elPY     = document.getElementById('py');

trackHit.src = "images/level_one.png";

// collision
var hit = new HitMap(trackHit);

// Keyboard Variables
var key = {
    UP: 38,
    DOWN: 40,
    LEFT: 37,
    RIGHT: 39
};

var keys = {
    38: false,
    40: false,
    37: false,
    39: false
};

function speedXY (rotation, speed) {
    return {
        x: Math.sin(rotation * TO_RADIANS) * speed,
        y: Math.cos(rotation * TO_RADIANS) * speed * -1
    };
}

function step (car) {
    if (car.code === 'player'){

        // constantly decrease speed
        if (!car.isMoving()){
            car.speed = 0;
        } else {
            car.speed *= car.speedDecay;
        }
        // keys movements
        if (keys[key.UP])  { car.accelerate(); }
        if (keys[key.DOWN]){ car.decelerate(); }
        if (keys[key.LEFT]){ car.steerLeft(); }
        if (keys[key.RIGHT]){ car.steerRight(); }

        var speedAxis = speedXY(car.rotation, car.speed);
        car.x += speedAxis.x;
        car.y += speedAxis.y;

        // collisions
        if (car.collisions.left.isHit(hit)){
            car.steerRight();
            car.decelerate(1);
        }
        if (car.collisions.right.isHit(hit)){
            car.steerLeft();
            car.decelerate(1);
        }
        if (car.collisions.top.isHit(hit)){
            car.decelerate(1);
        }
        if (car.collisions.bottom.isHit(hit)){
            car.decelerate(1);
        }

        // info
        elPX.innerHTML = Math.floor(car.x);
        elPY.innerHTML = Math.floor(car.y);
    }
}
function draw(car) {
    context.clearRect(0,0,ctxW,ctxH);
    drawRotatedImage(car.img, car.x, car.y, car.rotation);
    drawCollisionPoints(car);
}

function drawCollisionPoints(car) {
    context.beginPath();
    context.fillStyle = "red";
    var p = car.collisions.top.getXY();
    context.arc(p.x, p.y, 2, 0, 360 * TO_RADIANS);
    context.fill();
    context.closePath();

    context.beginPath();
    p = car.collisions.left.getXY();
    context.arc(p.x, p.y, 2, 0, 360 * TO_RADIANS);
    context.fill();
    context.closePath();

    context.beginPath();
    p = car.collisions.bottom.getXY();
    context.arc(p.x, p.y, 2, 0, 360 * TO_RADIANS);
    context.fill();
    context.closePath();

    context.beginPath();
    p = car.collisions.right.getXY();
    context.arc(p.x, p.y, 2, 0, 360 * TO_RADIANS);
    context.fill();
    context.closePath();
}

// Keyboard event listeners
$(window).keydown(function(e){
    if (keys[e.keyCode] !== 'undefined'){
        keys[e.keyCode] = true;
        // e.preventDefault();
    }
});
$(window).keyup(function(e){
    if (keys[e.keyCode] !== 'undefined'){
        keys[e.keyCode] = false;
        // e.preventDefault();
    }
});

function frame () {
    step(player);
    draw(player);
    window.requestAnimationFrame(frame);
}

frame();
