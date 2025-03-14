import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorsManager.mainRose,
          ), // Back button
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          'FAQ',
          style: GoogleFonts.inter(
            color: ColorsManager.mainRose,
            fontWeight: FontWeight.w700,
            fontSize: 18.0.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Make the AppBar transparent
        elevation: 0, // Remove AppBar shadow
      ),
      body: SafeArea(
        child: ListView(
          // Use ListView for scrollable content
          padding: const EdgeInsets.all(16.0),
          children: const <Widget>[
            FAQItem(
              question: "What is Wardaya?",
              answer:
                  "Wardaya is an online flowers platform based out of Saudi Arabia. That sells flower arrangements and was established with a mission of bringing your feelings to life. A while ago, we've made charity the backbone of our mission where we extend 1% of all revenue we make to doing good for the communities we operate in. It takes just a few clicks from our platform to place an order and have it delivered within a couple of hours.",
            ),
            FAQItem(
              question: "What does Wardaya do?",
              answer: "We deliver happiness!",
            ),
            FAQItem(
              question: "Do you have Debit Card / Credit Cards services?",
              answer:
                  "Yes, we accept various debit and credit cards for your convenience.", // Replace with actual answer
            ),
            FAQItem(
              question: "Can I place an order without creating an account?",
              answer:
                  "While creating an account offers benefits like order tracking and saving addresses, you can also place a guest order.", // Replace with actual answer
            ),
            FAQItem(
              question:
                  "If I placed an order, how long does it take to receive the order?",
              answer:
                  "Delivery times vary depending on your location. Typically, orders are delivered within a few hours.", // Replace with actual answer and be more specific if possible
            ),
            FAQItem(
              question: "Can I have multiple addresses into my account?",
              answer:
                  "Yes, you can add and manage multiple delivery addresses in your account for easy checkout.", // Replace with actual answer
            ),
            FAQItem(
              question: "Can I do one order with different dates?",
              answer:
                  "Currently, each order can only have one delivery date. For multiple dates, please place separate orders.", // Replace with actual answer
            ),
            FAQItem(
              question: "Can I track my orders?",
              answer:
                  "Yes, you can track your order status in your account or using the tracking number provided in your confirmation email.", // Replace with actual answer
            ),
            FAQItem(
              question: "What is celebrity Arrangements?",
              answer:
                  "Celebrity Arrangements are exclusive bouquets and designs inspired by renowned figures, often featuring premium flowers and unique styles.", // Replace with actual answer
            ),
            FAQItem(
              question: "What is Bundles?",
              answer:
                  "Bundles are curated sets of flowers and gifts, often offered at a special price, perfect for various occasions.", // Replace with actual answer
            ),
            FAQItem(
              question: "Can I order Cakes and balloons only?",
              answer:
                  "Yes, in addition to flowers, we also offer a selection of cakes and balloons that can be ordered independently or as additions to your floral orders.", // Replace with actual answer
            ),
            FAQItem(
              question: "I forgot to add an item to my order, what do I do?",
              answer:
                  "Please contact our customer service immediately. We'll do our best to assist you in adding the item to your existing order.", // Replace with actual answer
            ),
            FAQItem(
              question: "How long does the online payment refund process take?",
              answer:
                  "Refund processing times vary depending on your payment method and bank. Typically, it takes 5-7 business days.", // Replace with actual answer
            ),
            FAQItem(
              question: "How can I contact Wardaya?",
              answer:
                  "You can reach us through our website's contact form, by phone, or via email at [email protected]", // Replace with actual contact information
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          fontSize: 16.0.sp,
          color: ColorsManager.mainRose,
        ),
      ),
      collapsedIconColor: ColorsManager.mainRose,
      shape: Border.all(color: ColorsManager.transparent, width: 0.0),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40.0,
          ),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              answer,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w300,
                fontSize: 16.0.sp,
                color: ColorsManager.black,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
}
