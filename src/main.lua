function _init()
  -- enable mouse support
  poke(0x5f2d, 1)
  camera()

  init_globals()
  init_menu()
  load_entities()
end

function _draw()
  draw_map()
  replace_tiles()
  draw_entities()
  draw_camera()
  draw_menu()
  print_ressources()
  draw_mouse()
  print_log()
end

function _update()
  counter += 1
  update_entities()
  update_ressources()
  handle_inputs()
  update_mouse()
end


-- helpers
function print_log()
  if ((counter % 5) == 0) then
    cpu = (stat(1) * 100)
    ram = stat(0)
  end
  print('cpu: '..(cpu or 0)..'%', cam.x+1, cam.y+2, 0)  
  print('ram: '..(ram or 0)..'/1024', cam.x+1, cam.y+8, 0)
  print('entities: '..count(entities), cam.x+1, cam.y+14, 0)
  print(is_between_two_walls(flr(mouse.x/8), flr(mouse.y/8)), cam.x+1, cam.y+20, 0)
  print('counter: '..counter, cam.x+1, cam.y+26)

  -- flr(mouse.x/8), flr(mouse.y/8)
end