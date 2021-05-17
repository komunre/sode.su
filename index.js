const rl = require("serverline");

const Server = require("./server");

process.stdin.setEncoding("utf8");
process.stderr.setEncoding("utf8");

const PORT   = process.env.PORT || 443;
const server = new Server(PORT);

rl.init();
rl.setCompletion(["stop", "reload"]);
rl.setPrompt("> ");

rl.on("line", line => {
    console.log(line);

    const command = line.trim();

    switch (command) {
        case 'stop':
            server.stop();
        break;
        case 'reload':
            server.reload();
        break;
    }
});

rl.on("SIGINT", rl => {
    rl.question("Confirm exit: ", answer =>
        answer.match(/^y(es)?$/i)
                ? process.exit(0)
                : rl.output.write("\x1B[1K> "
            ))
})

server.start();
