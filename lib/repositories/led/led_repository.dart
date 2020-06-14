abstract class LedRepository {}

const messageOn = [0x71, 0x23, 0x0f];
const messageOff = [0x71, 0x24, 0x0f];
const messageInfo = [0x81, 0x8a, 0x8b];
const messageInfoLength = 14;
const on = 0x23;
const persist = 0x31;
const temporary = 0x41;
