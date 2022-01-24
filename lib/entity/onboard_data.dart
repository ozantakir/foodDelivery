class Onboarding {
  final String title;
  final String image;

  Onboarding({required this.title,required this.image});

}

List<Onboarding> onboardingContents = [
  Onboarding(title: "Look through our menu", image: "pics/onboard_one.png"),
  Onboarding(title: "Decide what you want to eat", image: "pics/onboard_two.png"),
  Onboarding(title: "And eat in no time", image: "pics/onboard_three.png"),
];