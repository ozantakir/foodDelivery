class Onboarding {
  final String title;
  final String image;

  Onboarding({required this.title,required this.image});

}

List<Onboarding> onboardingContents = [
  Onboarding(title: "Menümüze göz gezdirin", image: "pics/menu.gif"),
  Onboarding(title: "Ne istediğinize karar verin", image: "pics/decide.gif"),
  Onboarding(title: "Ve hemen size getirelim", image: "pics/eat.gif"),
];