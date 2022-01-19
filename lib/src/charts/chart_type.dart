enum ChartType {
  area,
  bar,
  column,
  calenderHeatMap,
  donut,
  line,
  curve,
  radar,
  pie,
  treeMap,
  timeSheet,
  gauge,
  wave,
  combine
}

extension ChartTypeName on ChartType {
  String get name {
    switch (this) {
      case ChartType.area:
        return '面积图';
      case ChartType.column:
        return '柱状图';
      case ChartType.bar:
        return '条形图';
      case ChartType.line:
        return '折线图';
      case ChartType.curve:
        return '曲线图';
      case ChartType.donut:
        return '环图';
      case ChartType.combine:
        return '混合图';
      case ChartType.radar:
        return '雷达图';
      case ChartType.pie:
        return '饼图';
      case ChartType.calenderHeatMap:
        return '日历热力图';
      case ChartType.treeMap:
        return '矩形树图';
      case ChartType.timeSheet:
        return '时序图';
      case ChartType.gauge:
        return '仪表盘';
      case ChartType.wave:
        return '波浪图';
      default:
        return '';
    }
  }
}
