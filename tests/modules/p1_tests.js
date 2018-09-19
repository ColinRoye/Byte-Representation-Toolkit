// generate input for p1
const fs = require('fs');

function invalidOp_args(){
    let list = [];
    for(let i = 0; i <= 127; i++){
        list.push([String.fromCharCode(i), 'INVALID_OPERATION']);
    }
    list = list.filter(char => char[0] !== 'F' && char[0] !== 'C' && char[0] !== '2');
    console.log(list)
    return list
}

function generateArgs(){
    let list = invalidOp_args();
    list.forEach((elm)=>{
        fs.appendFileSync('./../input/p1', elm + '\n');
    })

}

generateArgs();
