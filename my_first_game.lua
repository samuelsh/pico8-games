------ CONSTS ---------
PLAYER_SPR_1 = 1
PLAYER_SPR_2 = 2
PLAYER_SPR_3 = 3

ENEMY_SPR_1 = 5
ENEMY_ROCKET = 6
BOSS_SPR_1 = 7
BOSS_ROCKET = 8

MAP_BLOCK_1 = 4

------ GAME LOOP --------
function _init()
   player = {}
   enemy_1 = {}
   boss_1 = {}
   make_player()
   make_enemy()
   sfx(2)
end

function _update()
   move_player()
   move_enemy()
end

function _draw()
   cls() --clear screen
   map(0, 0)
   draw_player()
   draw_enemy()
end
------- GAME LOOP END ------


function make_player()
   player.x = 64
   player.y = 0
   player.sprite = PLAYER_SPR_1
   player.jumping = false
   player.jump_height = 0
   player.direction = 1
end

function make_enemy()
   enemy_1.x = 20
   enemy_1.y = 0
   enemy_1.falling = true
   enemy_1.direction = 1
   enemy_1.sprite = ENEMY_SPR_1
end

function move_player()
   local prev_px = player.x
   local prev_py = player.y
   if (btn(0)) then
      player.x -= 1
   elseif (btn(1)) then 
      player.x += 1
   end
   if (btn(2)) then
      if (not player.jumping) then 
         player.jumping = true
         player.direction = -1
         sfx(0)
      end
   end
   if (player.jumping) then
      player.jump_height += 1
      if (player.jump_height > 15) then
         player.jump_height = 0
         player.direction = 1
      end
   end
   player.y += player.direction
   if (check_collision(player.x, player.y + 7) == MAP_BLOCK_1) then
      player.y = prev_py
      player.jumping = false
   end
   if (check_collision(player.x, player.y) == MAP_BLOCK_1) then
      player.y = prev_py
      player.x = prev_px
   end
   if (check_collision(player.x + 7, player.y) == MAP_BLOCK_1) then
      player.x = prev_px
   end
   if (prev_px != player.x or prev_py != player.y) then
      player.sprite += 1  
      if (player.sprite > 3) then
         player.sprite = 1
      end
   end 
end

function move_enemy()
   if (enemy_1.falling == true) then
      enemy_1.y += 1
      if (check_collision(enemy_1.x, enemy_1.y + 7) == 4) then
         enemy_1.y -= 1
         enemy_1.falling = false
         return
      end
      return
   end
   if (check_collision(enemy_1.x + 7, enemy_1.y) == 4) then
      enemy_1.direction = -1
   elseif (check_collision(enemy_1.x, enemy_1.y) == 4) then
      enemy_1.direction = 1
   end
   enemy_1.x += enemy_1.direction
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