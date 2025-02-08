import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/theming/colors.dart';

class SuggestedMessagesBottomSheet extends StatefulWidget {
  final Function(String message) onMessageSelected;

  const SuggestedMessagesBottomSheet(
      {super.key, required this.onMessageSelected});

  @override
  State<SuggestedMessagesBottomSheet> createState() =>
      _SuggestedMessagesBottomSheetState();
}

class _SuggestedMessagesBottomSheetState
    extends State<SuggestedMessagesBottomSheet> with TickerProviderStateMixin {
  late TabController _tabController;

  // Sample suggested messages (replace with your actual data)
  final Map<String, List<String>> suggestedMessages = {
    'Birthday': [
      'Happy birthday! Wishing you all the best on your special day.',
      'May your birthday be filled with joy, love, and laughter.',
      'I hope you have a fantastic birthday filled with everything you wish for.',
    ],
    'Anniversary': [
      'Happy anniversary! Wishing you many more years of happiness together.',
      'Congratulations on another year of love and commitment.',
      'May your love continue to grow stronger with each passing year.',
    ],
    'Thank You': [
      'Thank you for your kind gesture. I really appreciate it.',
      'I am so grateful for your help and support.',
      'Your generosity is truly appreciated.',
    ],
    'Congratulations': [
      'Congratulations on your success! So proud of you',
      'Wishing you many more years of achievements',
      'Congratulations to you!',
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: suggestedMessages.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0.h),
      child: Scaffold(
        backgroundColor: ColorsManager.white,
        appBar: AppBar(
          backgroundColor: ColorsManager.white,
          title: Text(
            'Customize Gift Card',
            style: GoogleFonts.inter(
              color: ColorsManager.mainRose,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            color: ColorsManager.mainRose,
            onPressed: () => Navigator.pop(context),
          ),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: ColorsManager.mainRose,
            labelColor: ColorsManager.mainRose,
            unselectedLabelColor: ColorsManager.lighterLightGrey,
            dividerColor: ColorsManager.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 14.0.sp,
            ),
            tabs: suggestedMessages.keys
                .map((category) => Tab(text: category))
                .toList(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16.h),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: suggestedMessages.entries.map((entry) {
                    final messages = entry.value;
                    return _buildMessageList(messages);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList(List<String> messages) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.h),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorsManager.lightLighterGrey,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0.w,
                vertical: 8.0.h,
              ),
              child: InkWell(
                onTap: () {
                  widget.onMessageSelected(message);
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.h),
                  child: Text(
                    message,
                    style: GoogleFonts.inter(
                      color: ColorsManager.black,
                      fontSize: 14.0.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
