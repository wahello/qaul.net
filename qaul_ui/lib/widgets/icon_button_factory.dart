part of 'widgets.dart';

class IconButtonFactory extends StatelessWidget {
  const IconButtonFactory({
    Key? key,
    this.onPressed,
    this.icon = Icons.arrow_back_ios_rounded,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final IconData icon;

  factory IconButtonFactory.close({Key? key, VoidCallback? onPressed}) {
    return IconButtonFactory(onPressed: onPressed, icon: Icons.close_rounded);
  }

  @override
  Widget build(BuildContext context) {
    final l18ns = AppLocalizations.of(context)!;
    return IconButton(
      splashRadius: 24,
      tooltip: l18ns.backButtonTooltip,
      icon: Icon(icon),
      onPressed:
          onPressed != null ? onPressed! : () => Navigator.maybePop(context),
    );
  }
}