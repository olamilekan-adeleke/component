import 'package:intl/intl.dart';

String currencyFormatter(num amount, {String? locale}) {
  final NumberFormat formatter = NumberFormat(
    '${locale ?? "\u20A6"} #,##0',
    'en_US',
  );
  return formatter.format(amount);
}

String formatPhoneNumber(String phoneNumber) {
  // Remove any leading or trailing spaces
  phoneNumber = phoneNumber.trim();

  // Check if the phone number starts with '+'
  if (phoneNumber.startsWith('+')) {
    // Remove the '+' character for now
    phoneNumber = phoneNumber.substring(1);
  }

  // Add spaces at specific positions
  if (phoneNumber.length == 11) {
    // Format as +XXX XXX XXX XXX (11 digits)
    return '+${phoneNumber.substring(0, 4)} ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
  } else {
    // Handle other cases as needed
    return phoneNumber; // Return the original input if it doesn't match the expected format
  }
}
