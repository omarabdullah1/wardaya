import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';

class TACScreen extends StatelessWidget {
  const TACScreen({super.key});

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
          'Terms & Conditions',
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
          children: [
            Text(
              'Refund, Cancellation and Return Policy',
              style: GoogleFonts.inter(
                color: ColorsManager.black,
                fontWeight: FontWeight.w700,
                fontSize: 25.0.sp,
              ),
            ),
            const TACItem(
              question: "Compensation and Refund Policy",
              answer:
                  "Our Compensation and Refund Policy outlines the terms and conditions for refunds, including eligibility criteria, processing times, and any applicable deductions. Please review the policy for complete details.", // Replace with actual policy
            ),
            const TACItem(
              question: "Cancellation Policy",
              answer:
                  "Our Cancellation Policy explains the process for canceling orders, any applicable cancellation fees, and the timeframe within which cancellations are accepted. Please refer to the policy for specific information.", // Replace with actual policy
            ),
            const TACItem(
              question: "Rescheduling Orders",
              answer:
                  "Our Rescheduling Policy details the process for rescheduling orders, any associated fees, and any limitations on rescheduling. Please review the policy for details on how to reschedule your order.", // Replace with actual policy
            ),
            const TACItem(
              question: "Return Policy",
              answer:
                  "Our Return Policy outlines the conditions under which returns are accepted, the timeframe for returns, and the process for initiating a return. Please review the policy for complete details.", // Replace with actual policy
            ),
            Text(
              'Terms and Conditions',
              style: GoogleFonts.inter(
                color: ColorsManager.black,
                fontWeight: FontWeight.w700,
                fontSize: 25.0.sp,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'These terms (as well as all documents referred to herein) specify the Terms and Conditions (the “Terms”) which will apply when an order (‘Order’) is placed from the products (the “Products”) referred to on the Floward (‘Floward’, ‘Our’, ‘us’, ‘we’) website or mobile application(s) (iPhone or Android) (the “Platforms”). Please read these terms carefully before ordering any of our Products.If you have any questions concerning these Terms, please contact us before placing any Order. If you do not agree to these Terms, then you may not use the Platforms. Floward reserves the right to modify these Terms from time to time, at its sole discretion, without prior notice. You agree that each visit you make to the Platforms shall be subject to the then-current Terms and Conditions and Privacy Policy if applicable and continued use of the Platforms following modifications of these Terms confirms that you have read, accepted, and agreed to be bound by such modifications. If you do not accept the notified changes you may continue to use the Platforms and the Service in accordance with the existing terms, but certain new features may not be available to you. In the event you are a consumer, your legal rights will apply in addition to these Terms but will not replace them, unless there is a contradiction and the consumer rights are mandatory, then the consumer rights will prevail and apply. In all the countries in which we operate, and in addition to consumer rights, all laws and regulations relating to e-commerce and electronic transactions, as well as any specific laws to our industry, issued by any governmental authority, shall together with these Terms be applicable, unless a contradiction arises between these Terms and any mandatory law or regulation amongst the aforementioned laws and regulations. In such case, the mandatory law or regulation will prevail and apply. By setting up a Floward Account, you confirm your acknowledgement and acceptance of these Terms. You must be 18 or over to accept these terms and use the platforms or its related services. These terms also apply to all merchanting channels of the company and its affiliates including, but not limited to, the internet, telephone, catalog, radio, television, mobile device, social media and participating retail stores. By accessing any of the company merchandising channels, and any areas of the service, you agree to be legally bound, and to abide, by these terms. Please be aware that these terms contain a class action waiver that waive your right to a court hearing.',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w300,
                    fontSize: 16.0.sp,
                    color: ColorsManager.black,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            const TACItem(
              question: "PROHIBITED ACTIVITIES",
              answer:
                  "This section outlines activities that are strictly prohibited when using Wardaya's services. These may include unauthorized access, misuse of the platform, or any actions that violate applicable laws and regulations. Please review this section carefully.", // Replace with actual policy
            ),
            const TACItem(
              question: "CLOSURE OF ACCOUNT",
              answer:
                  "This section describes the conditions under which Wardaya may close or suspend your account, as well as the process for account closure and any potential consequences.", // Replace with actual policy
            ),
            const TACItem(
              question: "RESTRICTIONS FOR NON-PERSONAL AND NON-COMMERCIAL USE",
              answer:
                  "This section clarifies any restrictions on using Wardaya's services for purposes other than personal and non-commercial use. It outlines permitted and prohibited uses in relation to business or commercial activities.", // Replace with actual policy
            ),
            const TACItem(
              question: "GOVERNING LAW AND COMPETENT JURISDICTION",
              answer:
                  "This section specifies the legal jurisdiction that governs any disputes or legal matters related to Wardaya's services. It outlines which courts have authority in case of legal action.", // Replace with actual policy (be specific about the jurisdiction)
            ),
            const TACItem(
              question: "CIRCUMSTANCES OUTSIDE OUR CONTROL",
              answer:
                  "This section addresses situations or events beyond Wardaya's reasonable control that may affect service availability or performance, such as natural disasters, technical issues, or other unforeseen circumstances.", // Replace with actual policy (be specific about what circumstances are covered)
            ),
            const TACItem(
              question: "SEVERABILITY",
              answer:
                  "This clause clarifies that if any provision of the Terms and Conditions is found to be invalid or unenforceable, the remaining provisions will still remain in effect.", // Replace with actual policy
            ),
            const TACItem(
              question: "PERMISSION",
              answer:
                  "This section likely outlines the permissions you grant Wardaya by using their services, such as communication permissions, data usage permissions, etc.", // Replace with actual policy
            ),
            const TACItem(
              question: "INTELLECTUAL PROPERTY RIGHTS",
              answer:
                  "This section details the ownership of trademarks, copyrights, and other intellectual property related to Wardaya's platform and content.", // Replace with actual policy
            ),
            const TACItem(
              question: "CONTRIBUTION LICENSE",
              answer:
                  "This section specifies the terms under which users may contribute content to Wardaya's platform, granting Wardaya certain rights to use that content.", // Replace with actual policy (if applicable)
            ),
            const TACItem(
              question: "GENERAL LIMITATION OF LIABILITY",
              answer:
                  "This section clarifies the limitations of Wardaya's liability for information accuracy, service availability, and other potential issues. It may also address disclaimers related to product representations.", // Replace with actual policy
            ),
            const TACItem(
              question: "INDEMNIFICATION",
              answer:
                  "This section outlines the user's agreement to indemnify Wardaya from any legal claims or expenses arising from their use of the services.", // Replace with actual policy
            ),
            const TACItem(
              question: "DISCLAIMER",
              answer:
                  "This section clarifies the limitations of Wardaya's liability for information accuracy, service availability, and other potential issues. It may also address disclaimers related to product representations.", // Replace with actual policy
            ),
            const TACItem(
              question: "DATA PROTECTION",
              answer:
                  "This section explains how Wardaya handles user data, including collection, storage, and usage practices, in compliance with applicable data protection laws.", // Replace with actual policy, and be specific about what laws are referenced
            ),
            Text(
              'Privacy Policy',
              style: GoogleFonts.inter(
                color: ColorsManager.black,
                fontWeight: FontWeight.w700,
                fontSize: 25.0.sp,
              ),
            ),
            const TACItem(
              question: "Purpose of this privacy policy",
              answer:
                  "This privacy policy explains how Wardaya collects, uses, and protects your personal information. It describes the types of data we collect, how we use it, and your rights regarding your data.", // Replace with actual policy
            ),
            const TACItem(
              question: "The data we collect about you",
              answer:
                  "We collect various types of data, including personal contact information, order placement information, and potentially other data as described in the full policy. The specific data collected depends on your interactions with our services.", // Replace with actual policy
            ),
            const TACItem(
              question: "How is your personal data collected?",
              answer:
                  "We collect your personal data when you interact with our website or app, such as when you create an account, place an order, or contact customer service. We may also collect data automatically through cookies or similar technologies.", // Replace with actual policy
            ),
            const TACItem(
              question: "Personal Contact Information",
              answer:
                  "We may collect personal contact information such as your name, address, phone number, and email address to process your orders, communicate with you, and provide customer support.", // Replace with actual policy
            ),
            const TACItem(
              question: "How We Use Your Information",
              answer:
                  "We use your information for various purposes, including order fulfillment, customer service, personalization, marketing, and improving our services. We may also use your data for analytics and research purposes.", // Replace with actual policy
            ),
            const TACItem(
              question: "Your Email Address",
              answer:
                  "We use your email address to send you order confirmations, updates, marketing communications (with your consent), and other important information related to your account or our services.", // Replace with actual policy
            ),
            const TACItem(
              question: "Order Placement Information",
              answer:
                  "When you place an order, we collect information necessary to process and fulfill your order, including product details, delivery address, payment information, and order history.", // Replace with actual policy
            ),
            const TACItem(
              question: "Artificial Intelligence and Machine Learning",
              answer:
                  "We may use artificial intelligence and machine learning techniques to analyze data and improve our services, such as personalizing recommendations or optimizing delivery routes. This processing is done with appropriate safeguards to protect your privacy.", // Replace with actual policy (and be specific about what AI/ML is used for)
            ),
            const TACItem(
              question: "Protection of Your Personal Information",
              answer:
                  "We implement reasonable security measures to protect your personal information from unauthorized access, use, or disclosure. These measures include encryption, access controls, and regular security assessments.", // Replace with actual policy and be specific about the measures
            ),
            const TACItem(
              question: "How long is your information stored?",
              answer:
                  "We retain your personal information for as long as necessary to fulfill the purposes for which it was collected, comply with legal obligations, or resolve disputes. The retention period may vary depending on the type of data and the purpose of processing.", // Replace with actual policy and be specific about data retention periods if possible
            ),
            const TACItem(
              question: "Cookie Policy",
              answer:
                  "Our Cookie Policy explains how we use cookies and similar technologies on our website. It describes the types of cookies we use, their purpose, and your choices regarding cookies. Please review our Cookie Policy for more information.", // Replace with actual policy
            ),
            const TACItem(
              question: "Advertisements",
              answer:
                  "This section describes how Wardaya may display advertisements on its platform, including the types of ads you might see and how they are targeted. It may also cover your choices regarding ad preferences.", // Replace with actual policy
            ),
            const TACItem(
              question: "Marketing",
              answer:
                  "This section explains how Wardaya uses your information for marketing purposes, such as sending promotional emails or displaying targeted ads. It should also detail how you can opt out of marketing communications.", // Replace with actual policy
            ),
            const TACItem(
              question: "Discovering and Sharing Special Occasions",
              answer:
                  "This section may describe features that allow you to discover or share special occasions with others on the platform, such as creating wishlists, sending gifts, or sharing event information. It should also outline any privacy considerations related to these features.", // Replace with actual policy (if applicable)
            ),
            const TACItem(
              question: "Account Deletion, Data Deletion and Rights",
              answer:
                  "This section explains how you can delete your account and the data associated with it. It should also describe your rights regarding access, correction, and deletion of your personal information.", // Replace with actual policy. Be specific about the deletion process and data retention after deletion.
            ),
            const TACItem(
              question: "Data Security",
              answer:
                  "This section details the security measures Wardaya employs to protect your data from unauthorized access, use, or disclosure. It should cover technical safeguards, administrative procedures, and other relevant security practices.", // Replace with actual policy and be specific about the security measures.
            ),
            const TACItem(
              question: "Changes to Policy",
              answer:
                  "This section explains how and when Wardaya may update its privacy policy. It should describe how users will be notified of changes and when the new policy will take effect.", // Replace with actual policy
            ),
            const TACItem(
              question: "Contact Us",
              answer:
                  "This section provides contact information for reaching Wardaya's customer support or privacy team if you have questions or concerns about the privacy policy or your personal data.", // Replace with actual contact information (email, phone, address, etc.)
            ),
          ],
        ),
      ),
    );
  }
}

class TACItem extends StatelessWidget {
  final String question;
  final String answer;

  const TACItem({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          question,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 14.0.sp,
            color: ColorsManager.mainRose,
          ),
          textAlign: TextAlign.center,
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
