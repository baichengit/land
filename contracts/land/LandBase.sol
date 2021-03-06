pragma solidity ^0.4.23;

contract LandBase {

    uint256 constant CLEAR_LOW = 0xffffffffffffffffffffffffffffffff00000000000000000000000000000000;
    uint256 constant CLEAR_HIGH = 0x00000000000000000000000000000000ffffffffffffffffffffffffffffffff;
    uint256 constant FACTOR = 0x100000000000000000000000000000000;

    // encode

    function encodeTokenId(int _x, int _y) pure public returns (uint result) {
        return _encodeTokenId(_x, _y);
    }

    function _encodeTokenId(int _x, int _y) pure internal returns (uint result) {
        return _unsafeEncodeTokenId(_x, _y);
    }
    function _unsafeEncodeTokenId(int _x, int _y) pure internal returns (uint) {
        return ((uint(_x) * FACTOR) & CLEAR_LOW) | (uint(_y) & CLEAR_HIGH);
    }

    function _decodeTokenId(uint _value) pure internal returns (int x, int y) {
        (x, y) = _unsafeDecodeTokenId(_value);
    }

    function _unsafeDecodeTokenId(uint _value) pure internal returns (int x, int y) {
        x = expandNegative128BitCast((_value & CLEAR_LOW) >> 128);
        y = expandNegative128BitCast(_value & CLEAR_HIGH);
    }

    function expandNegative128BitCast(uint _value) pure internal returns (int) {
        if (_value & (1<<127) != 0) {
            return int(_value | CLEAR_LOW);
        }
        return int(_value);
    }

}
