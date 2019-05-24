
import 'dart:typed_data';

import 'package:pascaldart/common.dart';
import 'package:pascaldart/signing.dart';
import 'package:test/test.dart';

void main() {
  group('signing.operations.TransactionOperation', () {
    Map<String, dynamic> fixture;

    setUp(() {
      fixture = {
        'sender': 1440500,
        'target': 1440503,
        'senderPubkey': '3GhhbojvCFtyYSPxXfuk86uvJhURBEzF2fxV7x6kuW3Gi7ApSDd1scztAXGyeqphytxi6XibueQCoAG3yBCkXvg1BfGnosd6xKnKPT',
        'targetPubkey': '3GhhbojvCFtyYSPxXfuk86uvJhURBEzF2fxV7x6kuW3Gi7ApSDd1scztAXGyeqphytxi6XibueQCoAG3yBCkXvg1BfGnosd6xKnKPT',
        'amount': 0.0015,
        'fee': 0.0002,
        'payload': 'techworker',
        'n_operation': 4003,
        'r': '1201D10D537B0F6D7CB2032A768A851E0EF2426AA37756BCADB994AF189D124A',
        's': '9DACA47597ADFB3E529B82EB231396F464EE1C4E76DC6E85CD10CA3711C2D6C2',
        'raw': '0100000001000000F4FA1500A30F0000F7FA15000F0000000000000002000000000000000A0074656368776F726B657200000000000020001201D10D537B0F6D7CB2032A768A851E0EF2426AA37756BCADB994AF189D124A20009DACA47597ADFB3E529B82EB231396F464EE1C4E76DC6E85CD10CA3711C2D6C2'
      };      
    });

    test('can be decode a signed operation', () {
      TransactionOperation decoded = RawOperationCoder.decodeFromBytes(Util.hexToBytes(fixture['raw']));

      expect(Util.byteToHex(Util.encodeBigInt(decoded.signature.r)), fixture['r']);
      expect(Util.byteToHex(Util.encodeBigInt(decoded.signature.s)), fixture['s']);
      expect(decoded.sender.account, fixture['sender']);
      expect(decoded.target.account, fixture['target']);
      expect(decoded.amount.toStringOpt(), fixture['amount'].toString());
      expect(decoded.fee.toStringOpt(), fixture['fee'].toString());
      expect(decoded.nOperation, fixture['n_operation']);
      expect(Util.bytesToUtf8String(decoded.payload), fixture['payload']);
    });
  });
}
