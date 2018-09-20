const invalid_args = 'INVALID_ARGS'
function expect(a1) {
    if(a1.length > 32){
        console.log(a1.length)
        return invalid_args
    }
    let sign = a1.charAt(0);
    if(sign == "1" ){
        a1 = complement(a1)
    }
    let checkInvChar = a1;
        checkInvChar = checkInvChar.replace(/0|1/g, '');

    if(checkInvChar.length  !== 0){
        return invalid_args
    }
    if(sign == "0"){
        return ~~parseInt(a1,2)
    }
    return ~parseInt(a1,2)
}

function complement(a1) {
    let str = '';
    for(let i = 0; i < a1.length; i++) {

        if (a1.charAt(i) == "0") {
                str += "1"
            }
            else if (a1.charAt(i) == "1") {
                str += "0"
            }else{str += a1.charAt(i)}
        }
        return str
    }

console.log(expect("10000000000000000000000000000000"));

module.exports.expect_p2 = expect;





