import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/theming/colors.dart';

class DiscoverIdeasSection extends StatelessWidget {
  const DiscoverIdeasSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Text(
              context.el.discoverNewIdeasTitle,
              style: GoogleFonts.ebGaramond(
                fontSize: 32.sp,
                fontWeight: FontWeight.w400,
                color: ColorsManager.mainRose,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 300, // Adjust this based on your card height
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CardItem(
                    imageUrl:
                        'https://s3-alpha-sig.figma.com/img/217b/0b17/960993ea7aa7a47f8cc8ba3e5054cfdd?Expires=1739145600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mMXYvjZPb-cUPt-HDnC4RdcWITBwESiD-0Nittdw-p5PsG5WdTnDIMkoGBM-l~6VZGGQaA-lGFMRpsh-LUIALVC8mvFu7DxAFcNX11hn1Uq4MX4tW0l70E9sSv8ZVaO2YVVoL1TpR3GOnSeYUT6sHtQXKR3-DL3Hl-onZwQ6ZrwfYtxiBsybapx5jMA6JAiRV0nEGlW0gWwO2WLTKuW7p3i8lgPfpzoj-VTiGAdRhQEz7pxaV-didebKvmZcp0zR8t-u39CBg5b2E14R-gsa2psyV5gA-QkXuH2OIfQ-gEjpcfjGWF9cpoDZme9fwPTBni8kAmnQwo5JQAgrunQbSg__',
                    title: context.el.discoverCardExpressDeliveryTitle,
                    buttonText: context.el.discoverCardExpressDeliveryButton,
                  ),
                  const SizedBox(width: 10),
                  CardItem(
                    imageUrl:
                        'https://s3-alpha-sig.figma.com/img/f60e/e0fa/aec08996e634c5a4b34f2465507dc91e?Expires=1739145600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=kfuyyfWH2m-tmYJ5pIxk5D0kzwxo6GBOQQm4~ZMwzFc29-b5JYMoI5jlGWwgjjYtQWnQHSf6Lu2za7Zh~tik-~WocMLr4mvcB1i6~xpxcvhHf4Cw4m1ywVFuoBNnFK2OXQ9bEOxUmAvpLOYs1gLgahUCy8waluoCg9VeNK0qw7ueQdfj~BIDCa9BUZsoJRCCfBu0lE1inXnxZWRvwixAt2jGqrp6nW4VEsnrOgLqF~ZeZDdFttkxvIDmtguUQe37mWHhfULkofVmjEr79~M8kavGldwnOLcs5h~Y~gGQw69~cnGLQrevKdJbIJXktR8lzKH3lA4aAHm8Y93LbHKHvQ__',
                    title: context.el.discoverCardWeeklySurpriseTitle,
                    buttonText: context.el.discoverCardWeeklySurpriseButton,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String buttonText;

  const CardItem(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250, // Adjust width as needed
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            CachedNetworkImage(
              colorBlendMode: BlendMode.srcATop,
              color: Colors.black26,
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => _buildShadedPlaceholder(context),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: [0.0, 1.0],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                side: const BorderSide(color: Colors.white)),
                            child: Text(
                              buttonText,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShadedPlaceholder(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black,
            Colors.black,
          ],
          stops: [0.0, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.darken,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.withAlpha(51),
        ),
      ),
    );
  }
}
