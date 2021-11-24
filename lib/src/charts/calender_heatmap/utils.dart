leapYear(int year) {
  bool leapYear = false;
  bool leap = ((year % 100 == 0) && (year % 400 != 0));

  if (leap == true) {
    leapYear = false;
  } else if (year % 4 == 0) {
    leapYear = true;
  }

  return leapYear;
}

daysInMonth(int year, int month) {
  List<int> monthLength = List.filled(12, 0);

  monthLength[0] = 31;
  monthLength[2] = 31;
  monthLength[4] = 31;
  monthLength[6] = 31;
  monthLength[7] = 31;
  monthLength[9] = 31;
  monthLength[11] = 31;
  monthLength[3] = 30;
  monthLength[8] = 30;
  monthLength[5] = 30;
  monthLength[10] = 30;

  if (leapYear(year) == true) {
    monthLength[1] = 29;
  } else {
    monthLength[1] = 28;
  }

  return monthLength[month - 1];
}

yearLength(int year) {
  int yearLength = 0;

  for (int counter = 1; counter < year; counter++) {
    if (counter >= 4) {
      if (leapYear(counter) == true)
        yearLength += 366;
      else
        yearLength += 365;
    } else
      yearLength += 365;
  }
  return yearLength;
}

lastDayOfMonth(int year, int month) {
  return DateTime(year, month + 1, 0);
}

firstDayOfMonth(int year, int month) {
  return DateTime(year, month, 1).day;
}

List<String> weekDayTextEn = [
  'Mon',
  'Tue',
  'Wed',
  'Thur',
  'Fri',
  'Sat',
  'Sun',
];

List<String> weekDayTextCh = [
  '星期一',
  '星期二',
  '星期三',
  '星期四',
  '星期五',
  '星期六',
  '星期日',
];

List<String> monthTextEn = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

List<String> monthTextCn = [
  '一月',
  '二月',
  '三月',
  '四月',
  '五月',
  '六月',
  '七月',
  '八月',
  '九月',
  '十月',
  '十一月',
  '十二月',
];
