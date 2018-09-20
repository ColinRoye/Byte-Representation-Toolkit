const fs = require('fs');
var exec = require('child_process').exec;


function test(args){
    while(args.length > 0){
        console.log(args)
        let arg = args.pop()
        let expected = expectedFunc(arg);
        exec('cd .. && java -jar Fall18Mars.jar --noGui hw1.asm --argv ' + arg,
            async function (error, stdout, stderr) {
                stdout = stdout.slice(69)
                await fs.appendFileSync('./output/p2', expected + ',');
                await fs.appendFileSync('./output/p2', stdout);

                if (error !== null) {
                    console.log('exec error: ' + error);
                }

            });
    }
}

async function initArgs(argsFile){
    let args = await fs.readFileSync(argsFile);
    args = args.toString('utf8').replace(/r/g, '')
    args = args.split('\n');
    args = args.filter(arg => arg.length !== 1)
    return args
}

async function run(argsFile, expectedFunc){
    let args = await initArgs();
    test(args, expectedFunc);
}

function expectedFunc(){
    return 'test'
}






// const fs = require('fs');
// var exec = require('child_process').exec;
// const cluster = require('cluster');
// var child;
// let counter = 0;
// const numCPUs = require('os').cpus().length;
//
// function test(args) {
//     if (cluster.isMaster) {
//         console.log(`Master ${process.pid} is running`);
//
//         // Fork workers.
//         for (let i = 0; i < numCPUs && i < args.length-1; i++) {
//             if(args.length > 0){
//                 cluster.fork(testHelper(args.pop()));
//             }
//         }
//
//
//         cluster.on('exit', (worker, code, signal) => {
//             console.log(`worker ${worker.process.pid} died`);
//             if(args.length > 0){
//                 cluster.fork(testHelper(args.pop()));
//             }
//         });
//     } else {
//         console.log(`Worker ${process.pid} started`);
//     }
// }
// function testHelper(arg){
//     exec('cd .. && java -jar Fall18Mars.jar --noGui hw1.asm --argv ' + arg,
//          async function (error, stdout, stderr) {
//             stdout = stdout.slice(69)
//             await fs.appendFileSync('./output/p2', stdout+',expected output');
//             if (error !== null) {
//                 console.log('exec error: ' + error);
//             }
//              if(args.length > 0){
//                  cluster.fork(testHelper(arg));
//              }
//         });
// }
//
// async function initArgs(){
//     let args = await fs.readFileSync('./input/p2');
//     args = args.toString('utf8').split('\n');
//     console.log(args)
//     return args
// }
//
// async function begin(){
//     let args = await initArgs()
//     test(args);
// }
//
begin()
