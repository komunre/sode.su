const Server = require("./server");

process.stdin.setEncoding("utf8");
process.stderr.setEncoding("utf8");

const PORT = process.env.PORT || 443;

const server = new Server(PORT);

this.rl = require("readline").createInterface({
    input:    process.stdin,
    output:   process.stdout,
    terminal: false
});

this.rl.on("line", line => {
    if (line !== null) {
        const command = line.trim();

        switch (command) {
        case 'q':
            server.stop();
        break;
        case 'r':
            server.reload();
        break;
        }
    }
});

server.start();
