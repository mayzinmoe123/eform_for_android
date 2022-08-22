String replaceFarsiNumber(String input) {
  var StrInput = input.toString();
  const eng = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const mya = ['၀','၁','၂','၃','၄','၅','၆','၇','၈','၉'];

  for (int i = 0; i < eng.length; i++) {
    StrInput = StrInput.replaceAll(eng[i], mya[i]);
  }
  return StrInput;
}