local ws, err = http.websocket("ws://81.2.127.172:9397/")

if err then
  print(err)
else
  if ws then
    print(ws.receive())
    ws.send("Hello from ComputerCraft")
  end
end