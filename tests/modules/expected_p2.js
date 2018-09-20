const invalid_args = 'INVALID_ARGS'
function expect(a1) {
    if(a1.length >= 32){
        return invalid_args
    }
    let checkInvChar = a1.replace('1', '');
    checkInvChar = a1.replace('0', '');

    if(checkInvChar.length  !== 0){
        return invalid_args
    }

    return ~~parseInt(a1,2)
}
module.exports.expect_p2 = expect

