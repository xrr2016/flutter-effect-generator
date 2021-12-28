import '../exports.dart';
import './charts_controller.dart';

class ChartContainer extends StatelessWidget {
  final Widget title;
  final Widget? legend;
  final ChartType? type;
  final CustomPainter painter;

  const ChartContainer({
    Key? key,
    this.type,
    this.legend,
    required this.title,
    required this.painter,
  }) : super(key: key);

  Widget _renderLegend() {
    if (legend != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: legend,
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, BoxConstraints covariant) {
        debugPrint(covariant.maxWidth.toString());
        debugPrint(covariant.maxHeight.toString());

        double width = 0.0;

        switch (type) {
          case ChartType.calenderHeatMap:
            width = covariant.maxWidth;
            break;
          case ChartType.treeMap:
            width = covariant.maxWidth - 400.0;
            break;
          default:
            width = covariant.maxWidth - 200.0;
            break;
        }

        type == ChartType.calenderHeatMap
            ? covariant.maxWidth
            : covariant.maxWidth - 200.0;

        double height = type == ChartType.calenderHeatMap
            ? covariant.maxHeight - 400.0
            : covariant.maxHeight - 140.0;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
              child: title,
            ),
            CustomPaint(
              painter: painter,
              child: SizedBox(
                width: width,
                height: height,
                // color: Colors.red,
              ),
            ),
            _renderLegend(),
          ],
        );
      },
    );
  }
}
