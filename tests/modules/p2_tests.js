
const fs = require('fs');
var exec = require('child_process').exec;
const cluster = require('cluster');
var child;
let counter = 0;
const numCPUs = require('os').cpus().length;


if (cluster.isMaster) {
    console.log(`Master ${process.pid} is running`);

    // Fork workers.
    for (let i = 0; i < numCPUs; i++) {
        cluster.fork(test('C 111102365 7 2'));
    }


    cluster.on('exit', (worker, code, signal) => {
        console.log(`worker ${worker.process.pid} died`);
    });
} else {
    console.log(`Worker ${process.pid} started`);
}

function test(args){
    exec('cd .. && cd .. && java -jar Fall18Mars.jar --noGui hw1.asm --argv ' + args,
        async function (error, stdout, stderr) {
            stdout = stdout.slice(69)
            //console.log(stdout)
            await fs.appendFileSync('./../input/p2', stdout);
            if (error !== null) {
                console.log('exec error: ' + error);
            }

            //console.log(`Worker ${process.pid} died`);
            cluster.fork(test('C 111102365 7 2'));

            console.log(counter++);
        });
}










