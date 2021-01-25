local ws, err

function connect()
  ws, err = http.websocket("ws://81.2.127.172:9397/")
end

function save_file(data)
  local words = {}
  for word in s:gmatch("%w+") do table.insert(words, word) end
  local file = io.open(words[0], "w")
  file:write(strsub(data, words[0].len() + 1))
  file:close()
end

function run_file(data)
  local output = shell(data)
  
  local file = io.open("output.tmp", "r")
  local output_data = ""
  local line = file:read()
  
  repeat
    line = file:read()
    output_data = output_data .. line
  until line == nil
  file:close()

  ws.send(output_data)
end

--- rpc handler
function handle()
  ws.send("iden " .. os.getComputerID())

  local data = ws.receive()

  if not data then return false

  if data == "ping" then ws.send("pong") end
  if string.find("save", data) then
    save_file(data)
  end
  if string.find("runf", data) then
    run_file(data)
  end
  if 
end

connect()

if err then
  print(err)
else
  if ws then
    while true do
      local result = handle()
      if not handle() then
        os.sleep(3)
        connect()
      end

      if result == "shutdown" then
        print("shutting down")
        break
      end
    end
  end
end