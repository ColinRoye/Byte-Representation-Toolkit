const ieee = require('./ieee.js').ieee
const invalid_args = 'INVALID_ARGS'
function expect(a1){
    if(a1.length != 8){
        return invalid_args
    }
    if(a1 == '7F800000'){
        return '+Inf'
    }
    if(a1 == 'FF800000'){
        return '+Inf'
    }
    if(a1 == '00000000' || a1 == '80000000'){
        return 'Zero'
    }

    let ieee32 = new ieee(32);
    //return "1." + ieee32.Hex2Bin(a1).substring(1) + "_2*2" + ieee32.BinaryPower
    try{
        let ans = ieee32.Hex2Bin(a1)
        if(ans[0].includes('NaN')){
            return 'NaN'
        }
        if(ans[1].charAt(0) == '1'){
            return "-1." + ans[1].substring(9) + "_2*2^" + ieee32.BinaryPower
        }
        return "1." + ans[1].substring(9) + "_2*2^" + ieee32.BinaryPower

    }catch(e){
        return invalid_args
    }
}

console.log(expect('FF800002'));

module.exports.expect_p3 = expect
