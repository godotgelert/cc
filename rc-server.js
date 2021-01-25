const WebSocket = require("ws");

const wss = new WebSocket.Server({ port: 9397 });

var connected = [];

wss.on("connection", function connection(ws) {
  ws.on("message", function incoming(message) {
    if (message.startsWith("iden")) {
      connected.push({
        ws,
        id: message.split(" ")[1],
      });

      console.log("cc connected: ", connected[connected.length - 1].id);
    }

    if (message.startsWith("pong")) {
      console.log("cc ponged: ", connected[connected.length - 1].id);
    }
  });

  ws.send("ping");

  ws.send("save test.lua print('hello world!')\nprint('byeee')");
  ws.send("runf test.lua");

  ws.on("close", function closed() {
    let todelete = connected.findIndex((c) => {
      return c.ws === ws;
    });

    connected.splice(todelete, 1);
  });
});
