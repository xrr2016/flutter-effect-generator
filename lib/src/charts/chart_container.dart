import '../exports.dart';

class ChartContainer extends StatelessWidget {
  final Widget title;
  final Widget? legend;
  final CustomPainter painter;

  const ChartContainer({
    Key? key,
    required this.title,
    required this.painter,
    this.legend,
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

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
              child: title,
            ),
            CustomPaint(
              painter: painter,
              child: SizedBox(
                width: covariant.maxWidth - 200.0,
                height: covariant.maxHeight - 140.0,
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
