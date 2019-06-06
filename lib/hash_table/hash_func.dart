/**
 **************************************************************************
 *                                                                        *
 *          General Purpose Hash Function Algorithms Library              *
 *                                                                        *
 * Original Author: Arash Partow - 2002                                   *
 * Second Author: Buerkut - 2019                                          *
 * URL: http://www.partow.net                                             *
 * URL: https://github.com/Buerkut/Data-Structures-and-Algorithms-in-dart *
 *                                                                        *
 * Copyright notice:                                                      *
 * Free use of the General Purpose Hash Function Algorithms Library is    *
 * permitted under the guidelines and in accordance with the MIT License. *
 * http://www.opensource.org/licenses/MIT                                 *
 *                                                                        *
 **************************************************************************
*/

/// DJB Hash Function
int DJBHash(String str) {
  var rst = 5381;
  for (var cu in str.codeUnits) rst += (rst << 5) + cu;
  return rst;
}

/// ELF Hash Function
int ELFHash(String str) {
  var rst = 0, t = 0;
  for (var cu in str.codeUnits) {
    rst = (rst << 4) + cu;
    if ((t = rst & 0xF0000000) != 0) rst ^= t >> 24;
    rst &= ~t;
  }
  return rst;
}

/// DEK Hash Function
int DEKHash(String str) {
  var rst = str.length;
  for (var cu in str.codeUnits) rst = ((rst << 5) ^ (rst >> 27)) ^ cu;
  return rst;
}

/// RS Hash Function
int RSHash(String str) {
  var a = 63689, b = 378551, rst = 0;
  for (var cu in str.codeUnits) {
    rst = rst * a + cu;
    a *= b;
  }
  return rst;
}

/// JS Hash Function
int JSHash(String str) {
  var rst = 1315423911;
  for (var cu in str.codeUnits) rst ^= (rst << 5) + cu + (rst >> 2);
  return rst;
}

/// P. J. Weinberger Hash Function
int PJWHash(String str) {
  var BitsInUnsignedInt = 32,
      ThreeQuarters = (BitsInUnsignedInt * 3) ~/ 4,
      OneEighth = BitsInUnsignedInt ~/ 8,
      HighBits = (0xFFFFFFFF) << (BitsInUnsignedInt - OneEighth),
      test = 0,
      rst = 0;

  for (var cu in str.codeUnits) {
    rst = (rst << OneEighth) + cu;
    if ((test = rst & HighBits) != 0)
      rst = (rst ^ (test >> ThreeQuarters)) & (~HighBits);
  }
  return rst;
}

/// BKDR Hash Function
int BKDRHash(String str) {
  var seed = 131, rst = 0;
  for (var cu in str.codeUnits) rst = rst * seed + cu;
  return rst;
}

/// SDBM Hash Function
int SDBMHash(String str) {
  var rst = 0;
  for (var cu in str.codeUnits) rst = cu + (rst << 6) + (rst << 16) - rst;
  return rst;
}

/// BP Hash Function
int BPHash(String str) {
  var rst = 0;
  for (var cu in str.codeUnits) rst = rst << 7 ^ cu;
  return rst;
}

/// FNV Hash Function
int FNVHash(String str) {
  var fnv_prime = 0x811C9DC5, rst = 0;
  for (var cu in str.codeUnits) rst = (rst * fnv_prime) ^ cu;
  return rst;
}

/// AP Hash Function */
int APHash(String str) {
  var rst = 0xAAAAAAAA;
  for (var i = 0; i < str.length; i++)
    if ((i & 1) == 0)
      rst ^= (rst << 7) ^ str.codeUnitAt(i) * (rst >> 3);
    else
      rst ^= ~((rst << 11) + str.codeUnitAt(i) ^ (rst >> 5));

  return rst;
}
