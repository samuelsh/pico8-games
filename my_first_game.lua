------ GAME LOOP --------
function _init()
   player = {}
   enemy_1 = {}
   boss_1 = {}
   make_player()
   make_enemy()
end

function _update()
   move_player()
   move_enemy()
end

function _draw()
   cls() --clear screen
   map(0,0)
   draw_player()
   draw_enemy()
end
------- GAME LOOP END ------


function make_player()
   player.x = 64
   player.y = 0
   player.sprite = 1
end

function make_enemy()
   enemy_1.x = 20
   enemy_1.y = 0
   enemy_1.falling = true
   enemy_1.direction = 1
   enemy_1.sprite = 5
end

function move_player()
   prev_px = player.x
   prev_py = player.y
   if (btn(0)) player.x -= 1
   if (btn(1)) player.x += 1
   if (btn(2)) then    if (check_collision(enemy_1.x, enemy_1.y + 7) == 4) then
      enemy_1.y -= 1
   end
      player.y -= 5
      sfx(0)
   end
   player.y += 1
   if (check_collision(player.x, player.y + 7) == 4) then
      player.y -= 1
   end
   --if (btn(2)) py -= 1
   --if (btn(3)) py += 1
   if (prev_px != player.x or prev_py != player.y) then
      player.sprite += 1  
      if (player.sprite > 3) then
         player.sprite = 1
      end
   end 
end

function move_enemy()
   prev_px = enemy_1.x
   prev_py = enemy_1.y
   if (enemy_1.falling == true) then
      enemy_1.y += 1
      if (check_collision(enemy_1.x, enemy_1.y + 7) == 4) then
         enemy_1.y -= 1
         enemy_1.falling = false
         return
      end
      return
   end
   enemy_1.x += enemy_1.direction
   if (check_collision(enemy_1.x + 7, enemy_1.y) == 4) then
      enemy_1.direction = -1
   elseif (check_collision(enemy_1.x, enemy_1.y) == 4) then
      enemy_1.direction = 1
   end
end

function draw_player()
   spr(player.sprite, player.x, player.y)
end

function draw_enemy()
   spr(enemy_1.sprite, enemy_1.x, enemy_1.y)
end


function check_collision(x, y)
   return mget(flr(x/8), flr(y/8))
end    
