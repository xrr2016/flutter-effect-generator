import '../exports.dart';

class HomeCard extends StatelessWidget {
  final String title;

  const HomeCard({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.restorablePushNamed(
          context,
          ChartsView.routeName,
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            child: FlutterLogo(size: 80.0),
          ),
          SizedBox(height: 10.0),
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
