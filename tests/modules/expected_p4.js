const invalid_args = 'INVALID_ARGS'
let bc = require('base-conversion')
function expect(a1,a2,a3){

    if(parseInt(a2) > 10 || parseInt(a2) < 2){
        return invalid_args;
    }
    if(parseInt(a3) > 10 || parseInt(a2) < 2){
        return invalid_args;
    }

    for(let i = 0; i < a1.length; i++){
        console.log(a1.charCodeAt(i));
        if(a1.charCodeAt(i)-48 <= 9){
            if(a1.charCodeAt(i)-48 >= parseInt(a2)){
                return invalid_args
            }
        }
    }

    if(parseInt(a2) > 10 || parseInt(a2) < 2){
        return invalid_args
    }

    var hexToBin = bc(parseInt(a2), parseInt(a3));

    let ans = hexToBin(a1);
    if(ans == ''){
        return 0
    }
    return ans
}


module.exports.expect_p3 = expect
