
const fs = require('fs');
var exec = require('child_process').exec;
var child;

function test(args){
    exec('cd .. && cd .. && java -jar Fall18Mars.jar --noGui hw1.asm --argv ' + args,
        async function (error, stdout, stderr) {
            stdout = stdout.slice(69)
            console.log(stdout)
            await fs.appendFileSync('./../input/p2', stdout);
            if (error !== null) {
                console.log('exec error: ' + error);
            }
        });
}

test('C 111102365 7 2')











